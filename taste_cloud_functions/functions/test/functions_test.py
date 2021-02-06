import json
import pprint
import logging
import os
import signal
import sys
import time
import datetime
from typing import List

import firebase_admin
import pytest
import requests
import sh
from firebase_admin import firestore
from google.cloud import firestore as gfs

from algoliasearch.search_client import SearchClient
from algoliasearch.search_index import SearchIndex

algolia_client = SearchClient.create("4RPU12EN5A", "1b522e68ea0f95a796740366e9ebd577")

FIRESTORE_PORT = 8080
FNS_PORT = 5001


@pytest.fixture
def discover_index() -> SearchIndex:
    index = algolia_client.init_index("discover")
    index.clear_objects()
    yield index
    index.clear_objects()


PROJECT_ID = "FIREBASE_DEV_PROJECT"

os.environ["FIRESTORE_EMULATOR_HOST"] = f"localhost:{FIRESTORE_PORT}"

logger = logging.getLogger()


def clear_firestore():
    return requests.delete(
        f"http://localhost:{FIRESTORE_PORT}/emulator/v1/projects/FIREBASE_DEV_PROJECT/databases/(default)/documents"
    )


class _Client:
    instance = None


# Repeatedly check for a matched assertion.
# This is required, as triggers take a variable amount of time to respond,
# sometimes 10+ seconds.
def assert_delayed(reference, expected, test_fn=None):
    reference = (
        reference
        if isinstance(reference, gfs.DocumentReference)
        else _Client.instance.document(reference)
    )
    if not test_fn:

        def test_fn(a, b):
            return a == b

    _DELAY_SECONDS = 50

    def normalize(d):
        if isinstance(d, dict):
            return {k: normalize(v) for k, v in d.items() if v}
        if isinstance(d, list):
            return [normalize(v) for v in d]
        return d

    def fetch():
        return normalize(reference.get().to_dict())

    expected = normalize(expected)
    i = 0
    v = fetch()
    while not test_fn(v, expected):
        i += 1
        if i >= _DELAY_SECONDS:
            assert test_fn(v, expected)
            return v
        print(f"tick {_DELAY_SECONDS - i} {v} {expected}")
        time.sleep(1)
        v = fetch()
    return v


def subselect(field: str):
    parts = field.split(".")

    def helper(a, b):
        c = a
        for part in parts:
            c = c.get(part, {})
        return c == b

    return helper


def assert_delayed_count(reference, expected):
    return assert_delayed(reference, expected, subselect("counts"))


def _is_emulator_running() -> bool:
    """Returns true if an emulator is detected to already be running."""
    return bool(sh.sh("is_emulator_running.sh").strip())


@pytest.fixture(scope="session", autouse=True)
def run_emulator():
    """Once per entire test-suite: starts the emulator, runs tests, and terminates after."""
    firebase_options = {"projectId": PROJECT_ID}
    firebase_admin.initialize_app(options=firebase_options)
    _Client.instance = firestore.client()
    # if _is_emulator_running():
    #     logger.info("emulator running already, skipping creation")
    #     yield
    #     return
    # logger.info(
    #     "existing emulator not detected: starting new one up, and shutting down at completion of tests."
    # )
    # safe_to_start = []

    # def _read(line, stdin):
    #     print(line.strip())
    #     if safe_to_start or ("it is now safe to connect" in line):
    #         safe_to_start.append(True)

    # process = sh.firebase(
    #     "emulators:start",
    #     "--only",
    #     "functions,firestore",
    #     "--debug",
    #     _bg=True,
    #     _out=_read,
    # )
    # while not safe_to_start:
    #     time.sleep(0.25)
    # yield
    # process.signal(signal.SIGINT)


class Status:
    """Wraps a return value from cloud function.

    All values returned from cloud functions are wrapped in a `Status` protocol. This class
    understands this protocol and provides shorthands to access fields in the result.
    """

    def __init__(self, payload):
        self._payload = payload

    @property
    def is_success(self):
        return self._payload["success"]

    @property
    def val(self):
        assert self.is_success
        return self._payload["value"]

    @property
    def ref(self):
        return self.val["reference"]

    @property
    def reason(self):
        assert not self.is_success
        return self._payload["reason"]


@pytest.fixture(autouse=True)
def client() -> gfs.Client:
    """Executed before each test to ensure the client exists and previous data is cleared.

    Note that this prevents us from running tests in parallel.
    """
    clear_firestore()
    yield _Client.instance
    clear_firestore()


def call_fn(name: str, data: dict = {}) -> Status:
    """Calls a cloud function on the emulator and returns its result."""
    url = f"http://localhost:{FNS_PORT}/FIREBASE_DEV_PROJECT/us-central1/tasteCall"
    response = requests.post(
        url=url, json={"data": {"fn": name, "payload": data}}
    ).content
    logger.info(response)
    return Status(json.loads(response)["result"])


def direct_call_fn(name: str, data: dict = {}) -> Status:
    """Calls a cloud fn directly on the emulator and returns its result."""
    url = f"http://localhost:{FNS_PORT}/FIREBASE_DEV_PROJECT/us-central1/{name}"
    response = requests.post(url=url, json={"data": data}).content
    logger.info(response)
    return json.loads(response)


@pytest.fixture
def test_user(client):
    ref = client.collection("users").document("test-user-id")
    ref.create({'vanity': {'display_name': 'Jack Daniel Reilly', 'username': 'jdrusername'},'photo_url': 'https://superphoto'})
    ref.collection("private").document("private").create({})
    return ref


@pytest.fixture
def admin_user(client):
    ref = client.collection("users").document("admin-user-id")
    ref.create({"permissions": ["admin", "moderator"]})
    return ref


@pytest.fixture
def moderator_user(client):
    ref = client.collection("users").document("moderator-user-id")
    ref.create({"permissions": ["moderator"]})
    return ref


@pytest.fixture
def other_user(client):
    ref = client.collection("users").document("other-user-id")
    ref.create({})
    return ref


@pytest.fixture
def resto_ref():
    return _create_resto()


def _create_resto(name="jacko resto"):
    return call_fn(
        "createRestaurant", {"name": name, "location": {"lat": 10, "lng": 11}}
    ).val["reference"]


@pytest.fixture
def dish_ref(resto_ref):
    return _create_dish(resto_ref)


def _create_dish(resto_ref):
    return call_fn("createDish", {"name": "jacko dish", "restaurant": resto_ref}).val[
        "reference"
    ]


def first(collection: gfs.CollectionReference) -> gfs.DocumentSnapshot:
    """Returns first document in a collection."""
    return next(collection.stream())


@pytest.fixture
def photo_ref(
    test_user: gfs.DocumentReference, client: gfs.Client
) -> gfs.DocumentReference:
    """Returns a photo that exists in the db."""
    _, ref = test_user.collection("photos").add(
        {"firebase_storage_path": "fake-photo.png"}
    )
    assert len(list(test_user.collection("photos").stream())) == 1
    return ref


@pytest.fixture
def other_photo_ref(
    other_user: gfs.DocumentReference, client: gfs.Client
) -> gfs.DocumentReference:
    """Returns a photo that exists in the db."""
    _, ref = other_user.collection("photos").add(
        {"firebase_storage_path": "fake-photo.png"}
    )
    return ref


@pytest.fixture
def review_ref(dish_ref, client, photo_ref) -> str:
    """Returns a review that exists in the db."""
    return _create_review(dish_ref, client, photo_ref)


def _create_review(dish_ref, client, photo_ref):
    args = {
        "text": "great review",
        "reaction": "up",
        "photo": photo_ref.path,
        "dish": dish_ref,
    }
    return call_fn("createReview", args).ref


@pytest.fixture
def comment_ref(review_ref, client) -> str:
    """Returns a comment that exists in the db."""
    args = {"text": "great comment", "review": review_ref}
    return call_fn("addComment", args).ref


@pytest.fixture
def bookmark_ref(review_ref) -> str:
    """Returns a bookmark that on review_ref that exists in the db."""
    return _create_bookmark(review_ref)


def _create_bookmark(review_ref):
    return call_fn("bookmark", {"reference": review_ref}).ref


@pytest.fixture
def other_user_review_ref(
    dish_ref, client, photo_ref, other_user
) -> gfs.DocumentReference:
    """Returns a review created by some other user."""
    _, ref = (
        client.document(dish_ref)
        .collection("reviews")
        .add({"user": other_user, "reaction": "down"})
    )
    return ref


def wrap_call(fn: str, only_success=True, **defaults):
    """Wraps a cloud function call with default data, and kwargs overrides."""

    def helper(**overrides):
        args = dict(defaults)
        args.update(overrides)
        args = {k: v for k, v in args.items() if v is not None}
        result = call_fn(fn, args)
        if only_success:
            return result.is_success
        return result

    return helper


def test_clear_firestore(client: gfs.Client, other_user):
    assert len(list(client.collection("users").stream())) > 0
    clear_firestore()
    assert len(list(client.collection("users").stream())) == 0


def test_empty_trophies(client: gfs.Client):
    assert len(list(client.collection("reactions").stream())) == 0
    assert len(call_fn("listTrophies").val["references"]) == 0


def test_restaurant_not_enough_info():
    create = wrap_call(
        "createRestaurant", name="test-name", location={"lat": 23, "lng": -22}
    )
    assert create()
    assert not create(name=None)
    assert not create(name=42)
    assert not create(location={"lat": 2, "lng": "1"})


def test_create_resto_and_dish(client: gfs.Client, test_user):
    resto = call_fn(
        "createRestaurant", {"name": "jacko resto", "location": {"lat": 10, "lng": 11}}
    ).val["reference"]
    dish = call_fn("createDish", {"name": "jacko dish", "restaurant": resto}).val[
        "reference"
    ]
    resto_id = resto.split("/")[-1]
    resto_ref = client.collection("restaurants").document(resto_id)
    assert resto_ref.get().get("attributes") == {
        "name": "jacko resto",
        "location": gfs.GeoPoint(10, 11),
    }
    dish_id = dish.split("/")[-1]
    dish_ref = resto_ref.collection("dishes").document(dish_id)
    assert dish_ref.get().get("attributes") == {"name": "jacko dish"}
    resto_mod_ref = next(resto_ref.collection("moderations").stream())
    assert resto_mod_ref.get("creates") is True
    assert resto_mod_ref.get("user") == test_user
    dish_mod_ref = next(dish_ref.collection("moderations").stream())
    assert dish_mod_ref.get("creates") is True
    assert dish_mod_ref.get("user") == test_user


def test_dish_bad_ref(client, resto_ref: str):
    assert (
        call_fn("createDish", {"name": "dish", "restaurant": resto_ref}).is_success
        is True
    )
    assert (
        call_fn(
            "createDish", {"name": "dish", "restaurant": "restaurants/dne"}
        ).is_success
        is False
    )


def test_add_trophy(
    client: gfs.Client, resto_ref: str, test_user: gfs.DocumentReference
):
    assert call_fn("addTrophy", {"reference": resto_ref}).is_success is True
    assert first(
        client.collection("reactions")
        .where("type", "==", "trophy")
        .where("user", "==", test_user)
        .where("reference", "==", client.document(resto_ref))
    ).exists

    # Already exists
    assert not call_fn("addTrophy", {"reference": resto_ref}).is_success
    assert not call_fn("addTrophy", {"reference": "bogus/reference"}).is_success


def test_remove_trophy(
    client: gfs.Client, resto_ref: str, test_user: gfs.DocumentReference
):
    def add():
        return call_fn("addTrophy", {"reference": resto_ref}).is_success

    def remove():
        return call_fn("removeTrophy", {"reference": resto_ref}).is_success

    assert not remove()
    assert add()
    assert remove()
    assert not remove()


def test_swap_trophy(
    client: gfs.Client, resto_ref: str, dish_ref: str, test_user: gfs.DocumentReference
):
    def add(ref):
        return call_fn("addTrophy", {"reference": ref}).is_success

    def remove(ref):
        return call_fn("removeTrophy", {"reference": ref}).is_success

    def swap(in_ref, out_ref):
        return call_fn("swapTrophy", {"in": in_ref, "out": out_ref}).is_success

    def trophies_are(*expected):
        return set(call_fn("listTrophies").val["references"]) == set(expected)

    assert trophies_are()
    assert add(resto_ref)
    assert trophies_are(resto_ref)
    assert swap(dish_ref, resto_ref)
    assert trophies_are(dish_ref)
    assert not add(dish_ref)
    assert add(resto_ref)
    assert trophies_are(dish_ref, resto_ref)
    assert remove(resto_ref)
    assert trophies_are(dish_ref)
    assert not swap(dish_ref, resto_ref)
    assert not swap(dish_ref, dish_ref)
    assert not swap(resto_ref, resto_ref)
    assert swap(resto_ref, dish_ref)
    assert trophies_are(resto_ref)


def test_photo(photo_ref):
    assert photo_ref.get().get("firebase_storage_path") == "fake-photo.png"


def test_create_review_not_my_photo(
    client: gfs.Client, dish_ref: str, other_photo_ref, photo_ref
):
    review = wrap_call(
        "createReview", text="great_review", reaction="up", dish=dish_ref
    )
    # My photo.
    assert review(photo=photo_ref.path)
    # Not my photo.
    assert not review(photo=other_photo_ref.path)


def test_create_review(
    client: gfs.Client, resto_ref: str, dish_ref: str, photo_ref, other_photo_ref
):
    review = wrap_call(
        "createReview",
        text="great_review",
        reaction="up",
        photo=photo_ref.path,
        dish=dish_ref,
    )
    assert review(reaction="trophy")
    # text is optional
    assert review(text=None)
    assert not review(dish=None)
    assert not review(dish="not-a-dish")
    assert not review(photo=None)
    assert not review(photo="not-a-photo")
    assert not review(reaction="not-a-reaction")
    # add two more trophies.
    for _ in range(2):
        assert review(reaction="trophy")
    # now there's 3 trophies.
    # This one will fail because it's trying to add a 4th.
    assert not review(reaction="trophy")


def test_add_comment(client: gfs.Client, review_ref: str):
    comment = wrap_call("addComment", text="great comment", review=review_ref)
    assert comment()
    assert not comment(text=None)
    assert not comment(text="")
    assert not comment(text=42)
    assert not comment(review=None)
    assert not comment(review="not-a-review")


def test_publish_review(review_ref: str, other_user_review_ref):
    publish = wrap_call("publishReview", review=review_ref)

    # already unpublished
    assert not publish(publish=False)
    assert publish()
    # already published.
    assert not publish()
    assert publish(publish=False)
    # user doesn't own this review.
    assert not publish(review=other_user_review_ref.path)


def test_like_comment_or_review(
    comment_ref: str, review_ref: str, resto_ref: str, dish_ref: str
):
    like = wrap_call("likeCommentOrReview", comment_or_review=comment_ref)

    # already unliked
    assert not like(like=False)
    assert like()
    # already liked
    assert not like()
    assert like(like=False)
    assert like(like=True)
    assert not like(comment_or_review=None)
    assert not like(comment_or_review="not-a-comment")
    # reviews can be liked too.
    assert like(comment_or_review=review_ref)
    # But no for resto or dish.
    assert not like(comment_or_review=resto_ref)
    assert not like(comment_or_review=dish_ref)


def test_bookmark(comment_ref: str, review_ref, dish_ref, resto_ref):
    bookmark = wrap_call("bookmark", reference=review_ref)

    # already unbookmarked
    assert not bookmark(bookmark=False)
    assert bookmark()
    # already bookmarked
    assert not bookmark()
    # toggle
    assert bookmark(bookmark=False)
    assert bookmark(bookmark=True)

    assert not bookmark(reference=None)
    assert not bookmark(reference="not-a-reference")

    assert bookmark(reference=dish_ref)
    assert bookmark(reference=resto_ref)
    assert not bookmark(reference=comment_ref)


def test_follow(
    test_user: gfs.DocumentReference, other_user: gfs.DocumentReference, dish_ref
):
    follow = wrap_call("follow", user=other_user.path)

    # not following right now
    assert not follow(following=False)
    assert follow()
    # already followed
    assert not follow()
    # toggle
    assert follow(following=False)
    assert follow(following=True)

    assert not follow(user=None)
    assert not follow(user="not-a-user")
    # cannot follow yourself
    assert not follow(user=test_user.path)
    # cannot follow a dish
    assert not follow(user=dish_ref)


def test_request_permissions(test_user: gfs.DocumentReference, client):
    request = wrap_call("requestPermissions", permission="moderator")

    def exists(grant=True, permission="moderator"):
        try:
            return first(
                client.collection("permissions_requests")
                .where("user", "==", test_user)
                .where("permission", "==", permission)
                .where("grant", "==", grant)
            ).exists
        except StopIteration:
            return False
        except:
            pytest.fail()

    assert not exists()
    assert request()
    assert exists()
    assert not exists(grant=False)
    assert not exists(permission="admin")
    assert not request(permission=None)
    assert not request(permission="not-a-perm")
    assert request(permission="admin", grant=False)
    assert exists(permission="admin", grant=False)


def test_report_content(
    test_user: gfs.DocumentReference,
    client,
    resto_ref,
    review_ref,
    comment_ref,
    dish_ref,
):
    report = wrap_call(
        "reportContent",
        permission="moderator",
        text="something I am saying",
        reference=review_ref,
        only_success=False,
    )

    def get(ref):
        return client.document(ref).get()

    response = report()
    assert response.is_success
    ref = response.ref
    report_value = get(ref)
    assert report_value.reference.parent.parent == client.document(review_ref)
    report_value = report_value.to_dict()
    assert report_value["text"] == "something I am saying"
    assert report_value["user"] == test_user

    assert report(reference=review_ref).is_success
    assert report(reference=dish_ref).is_success
    assert report(reference=comment_ref).is_success
    assert not report(reference=None).is_success
    assert not report(reference="not-a-ref/not-ref").is_success


def test_grant_permissions_admin(admin_user: gfs.DocumentReference, client):
    request = wrap_call(
        "requestPermissions",
        permission="moderator",
        only_success=False,
        __test_user__=admin_user.id,
    )
    request_path = request().ref

    grant = wrap_call(
        "grantPermissions", request=request_path, __test_user__=admin_user.id
    )
    assert grant()
    assert grant(grant=False)
    assert not grant(request="permissions_requests/doesnotexist")
    assert not grant(grant="not-a-grant")


def test_grant_permissions_not_admin(moderator_user: gfs.DocumentReference, client):
    request = wrap_call(
        "requestPermissions",
        permission="moderator",
        only_success=False,
        __test_user__=moderator_user.id,
    )
    request_path = request().ref
    grant = wrap_call(
        "grantPermissions", request=request_path, __test_user__=moderator_user.id
    )
    assert not grant()


def test_moderate_item_moderator(
    moderator_user: gfs.DocumentReference, client, review_ref, resto_ref, dish_ref
):
    moderate = wrap_call(
        "moderateItem",
        reference=resto_ref,
        verified=True,
        __test_user__=moderator_user.id,
    )

    assert moderate()
    assert moderate(verified=False)
    # Require explicit verified value.
    assert not moderate(verified=None)

    assert moderate(reference=dish_ref)
    assert not moderate(reference=review_ref)
    assert not moderate(reference=None)

    def exists(verified=True, reference=resto_ref):
        try:
            return first(
                client.document(reference)
                .collection("moderation_decisions")
                .where("user", "==", moderator_user)
                .where("verified", "==", False)
            ).exists
        except StopIteration:
            return False
        except:
            pytest.fail()

    return exists()
    return exists(verified=False)
    return exists(reference=dish_ref)
    return not exists(reference=review_ref)


def test_moderate_item_not_moderator(
    test_user: gfs.DocumentReference, client, resto_ref
):
    moderate = wrap_call("moderateItem", reference=resto_ref, verified=True)
    assert not moderate()


def test_update_review(review_ref, other_user_review_ref, client):
    update = wrap_call(
        "updateReview", text="updated-text", reaction="down", review=review_ref
    )

    def get():
        result = client.document(review_ref).get()
        assert result.exists
        return result.to_dict()

    assert get()["text"] == "great review"
    assert get()["reaction"] == "up"
    assert update()
    assert get()["text"] == "updated-text"
    assert get()["reaction"] == "down"
    # not my review.
    assert not update(review=other_user_review_ref.path)
    # Text optional
    assert update(text=None)
    # Reaction optional
    assert update(reaction=None)
    # Both optional
    assert update(reaction=None, text=None)


def test_toggle_review_count(client, resto_ref, dish_ref, photo_ref):
    # Sensitive to delays in prior tests, add a sleep
    time.sleep(10)

    is_published = (
        lambda review: client.document(review).get().to_dict().get("published", False)
    )

    update = wrap_call("updateReview", text="updated-text", reaction="down")
    delete = wrap_call("deleteReview")

    def create():
        return _create_review(dish_ref, client, photo_ref)

    publish = wrap_call("publishReview")

    review_a = create()
    assert is_published(review_a)

    assert_delayed_count(dish_ref, {"up": 1})
    assert_delayed_count(resto_ref, {"up": 1})

    assert publish(review=review_a, publish=False)
    assert not is_published(review_a)
    assert_delayed_count(dish_ref, {"up": 0})
    assert_delayed_count(resto_ref, {"up": 0})

    assert publish(review=review_a)
    assert_delayed_count(dish_ref, {"up": 1})
    assert_delayed_count(resto_ref, {"up": 1})

    assert publish(review=review_a, publish=False)
    assert_delayed_count(dish_ref, {"up": 0})
    assert_delayed_count(resto_ref, {"up": 0})

    assert delete(review=review_a)
    assert_delayed_count(resto_ref, {"up": 0})


def test_multi_reviews_count(client, resto_ref, dish_ref, photo_ref):

    is_published = (
        lambda review: client.document(review).get().to_dict().get("published", False)
    )
    get_reaction = (
        lambda review: client.document(review).get().to_dict().get("reaction")
    )

    update = wrap_call("updateReview", text="updated-text", reaction="down")
    delete = wrap_call("deleteReview")

    def create(dish_ref=dish_ref):
        return _create_review(dish_ref, client, photo_ref)

    review_a = create()
    review_b = create()
    assert_delayed_count(dish_ref, {"up": 2})
    assert_delayed_count(resto_ref, {"up": 2})

    assert update(review=review_a, reaction="down")
    assert get_reaction(review_a) == "down"
    assert is_published(review_a)
    assert_delayed_count(dish_ref, {"up": 1, "down": 1})
    assert_delayed_count(resto_ref, {"up": 1, "down": 1})


def test_multi_dish_count(client, resto_ref, dish_ref, photo_ref):

    update = wrap_call("updateReview", text="updated-text", reaction="down")
    delete = wrap_call("deleteReview")
    publish = wrap_call("publishReview")

    def create(dish_ref=dish_ref):
        ref = _create_review(dish_ref, client, photo_ref)
        try:
            publish(review=ref)
        except Exception as e:
            print("already published", e)
        return ref

    dish_1_1 = dish_ref
    resto_1 = resto_ref
    dish_2_1 = _create_dish(resto_1)
    resto_2 = _create_resto()
    dish_1_2 = _create_dish(resto_2)

    reviews = []

    reviews.append(create(dish_1_1))
    reviews.append(create(dish_1_1))
    reviews.append(create(dish_1_1))

    reviews.append(create(dish_2_1))
    reviews.append(create(dish_2_1))

    reviews.append(create(dish_1_2))

    assert_delayed_count(dish_1_1, {"up": 3})
    assert_delayed_count(dish_2_1, {"up": 2})
    assert_delayed_count(dish_1_2, {"up": 1})

    assert_delayed_count(resto_1, {"up": 5})
    assert_delayed_count(resto_2, {"up": 1})

    for review in reviews:
        assert delete(review=review)

    assert_delayed_count(resto_1, {"up": 0})
    assert_delayed_count(resto_2, {"up": 0})


def test_add_geo_restaurant(client, resto_ref):
    def assert_delayed_geo(expected):
        return assert_delayed(resto_ref, expected, subselect("_spatial_index"))

    assert_delayed_geo({"cell_id": 1535641203})
    client.document(resto_ref).update(
        {"attributes": {"location": gfs.GeoPoint(11, 10)}}
    )
    assert_delayed_geo({"cell_id": 1317517297})


def test_following_count(client, other_user, test_user):
    follow = wrap_call("follow", user=other_user.path)

    def assert_counts(expected, user=test_user):
        return assert_delayed(user.path, expected, subselect("counts"))

    assert_counts({})
    assert_counts({}, user=other_user)
    assert follow()
    assert_counts({"following": 1})
    assert_counts({"follower": 1}, user=other_user)
    assert follow(following=False)
    assert_counts({})
    assert_counts({}, user=other_user)
    assert follow()
    assert_counts({"following": 1})
    assert_counts({"follower": 1}, user=other_user)
    assert follow(__test_user__=other_user.id, user=test_user.path)
    assert_counts({"following": 1, "follower": 1})
    assert_counts({"follower": 1, "following": 1}, user=other_user)


def test_bookmark_count(review_ref, resto_ref, dish_ref, other_user):
    bookmark = wrap_call("bookmark")

    def assert_bookmarks(reference, expected):
        return assert_delayed(reference, expected, subselect("counts.bookmark"))

    assert_bookmarks(review_ref, {})
    assert_bookmarks(dish_ref, {})
    assert_bookmarks(resto_ref, {})
    assert bookmark(reference=review_ref)
    assert_bookmarks(review_ref, 1)
    assert_bookmarks(dish_ref, 1)
    assert_bookmarks(resto_ref, 1)
    assert bookmark(reference=review_ref, __test_user__=other_user.id)
    assert_bookmarks(review_ref, 2)
    assert_bookmarks(dish_ref, 2)
    assert_bookmarks(resto_ref, 2)
    assert bookmark(reference=dish_ref)
    assert_bookmarks(review_ref, 2)
    assert_bookmarks(dish_ref, 3)
    assert_bookmarks(resto_ref, 3)
    assert bookmark(reference=resto_ref)
    assert_bookmarks(review_ref, 2)
    assert_bookmarks(dish_ref, 3)
    assert_bookmarks(resto_ref, 4)

    dish_2 = _create_dish(resto_ref)

    assert bookmark(reference=dish_2)

    assert_bookmarks(review_ref, 2)
    assert_bookmarks(dish_ref, 3)
    assert_bookmarks(dish_2, 1)
    assert_bookmarks(resto_ref, 5)

    assert bookmark(reference=review_ref, bookmark=False)
    assert_bookmarks(review_ref, 1)
    assert_bookmarks(dish_ref, 2)
    assert_bookmarks(dish_2, 1)
    assert_bookmarks(resto_ref, 4)


def test_like_count(review_ref, comment_ref, other_user):
    like = wrap_call("likeCommentOrReview")

    def assert_likes(reference, expected):
        return assert_delayed(reference, expected, subselect("counts.up"))

    assert_likes(review_ref, {})
    assert_likes(comment_ref, {})

    assert like(comment_or_review=review_ref)
    assert_likes(review_ref, 1)
    assert like(comment_or_review=review_ref, __test_user__=other_user.id)
    assert_likes(review_ref, 2)
    assert like(comment_or_review=review_ref, __test_user__=other_user.id, like=False)
    assert_likes(review_ref, 1)

    assert like(comment_or_review=comment_ref)
    assert_likes(comment_ref, 1)


def _now():
    return datetime.datetime.now(datetime.timezone.utc)


def test_resto_timestamps(resto_ref, client):
    extras = client.document(resto_ref).get().to_dict()["_extras"]
    created = extras["created_at"]
    updated = extras["updated_at"]
    assert 0 < (_now() - created).total_seconds() < 4
    assert created == updated


def test_review_timestamps(review_ref, client):
    extras = client.document(review_ref).get().to_dict()["_extras"]
    created = extras["created_at"]
    updated = extras["updated_at"]
    assert 0 < (_now() - created).total_seconds() < 4
    assert created == updated
    assert call_fn(
        "updateReview", {"review": review_ref, "text": "some really new text"}
    )
    extras = client.document(review_ref).get().to_dict()["_extras"]
    update_created = extras["created_at"]
    update_updated = extras["updated_at"]
    assert created == update_created
    assert updated < update_updated


def test_user_bookmarks(client, resto_ref, dish_ref, review_ref, test_user):
    bookmark = wrap_call("bookmark")
    assert bookmark(reference=resto_ref)
    assert bookmark(reference=dish_ref)
    assert bookmark(reference=review_ref)
    assert (
        len(
            list(
                client.collection_group("bookmarks")
                .where("user", "==", test_user)
                .stream()
            )
        )
        == 3
    )


def test_user_likes(client, review_ref, comment_ref, test_user):
    like = wrap_call("likeCommentOrReview")
    assert like(comment_or_review=comment_ref)
    assert like(comment_or_review=review_ref)
    assert (
        len(
            list(
                client.collection_group("likes").where("user", "==", test_user).stream()
            )
        )
        == 2
    )


def test_user_reviews(client, test_user, photo_ref, dish_ref, review_ref):
    assert (
        len(
            list(
                client.collection_group("reviews")
                .where("user", "==", test_user)
                .stream()
            )
        )
        == 1
    )
    _create_review(dish_ref, client, photo_ref)
    assert (
        len(
            list(
                client.collection_group("reviews")
                .where("user", "==", test_user)
                .stream()
            )
        )
        == 2
    )


def test_user_comments(client, review_ref, test_user, comment_ref):
    assert (
        len(
            list(
                client.collection_group("comments")
                .where("user", "==", test_user)
                .stream()
            )
        )
        == 1
    )
    call_fn("addComment", {"text": "great comment", "review": review_ref})
    assert (
        len(
            list(
                client.collection_group("comments")
                .where("user", "==", test_user)
                .stream()
            )
        )
        == 2
    )


def test_username(other_user, test_user, client):
    vanity = wrap_call("updateUserVanity", username="cooluser")

    def get(user):
        return user.get().to_dict().get("vanity", {}).get("username", None)

    # username not set yet
    assert get(test_user) is None
    assert get(other_user) is None
    # set it
    assert vanity()
    assert get(test_user) == "cooluser"
    # you can reset it to the same, no-op
    assert vanity()
    # you can change it!
    assert vanity(username="changeit")
    assert get(test_user) == "changeit"
    # another user can take your old name?
    # TODO(jackdreilly): Disallow username reuse.
    assert vanity(username="cooluser", __test_user__=other_user.id)
    assert get(other_user) == "cooluser"
    # username already taken
    assert not vanity(username="changeit", __test_user__=other_user.id)
    assert get(other_user) == "cooluser"
    # username must be >= 3 chars.
    assert not vanity(username="ch")


def test_vanity(photo_ref, test_user):
    vanity = wrap_call(
        "updateUserVanity",
        username="cooluser",
        photo=photo_ref.path,
        display_name="My Sweet Name",
    )
    assert vanity()
    assert {
        k: (v if not isinstance(v, gfs.DocumentReference) else v.path)
        for k, v in test_user.get().to_dict()["vanity"].items()
    } == {
        "username": "cooluser",
        "photo": photo_ref.path,
        "display_name": "My Sweet Name",
        "has_set_up_account": True,
    }


def test_add_fcm_token(client, test_user):
    add_token = wrap_call("addFCMToken", token="asdfaosdifhasdofi")

    def get_tokens():
        result = test_user.collection("private").document("private").get().to_dict()
        print(result)
        return result["fcm_tokens"]

    assert add_token()
    assert set(get_tokens()) == {"asdfaosdifhasdofi"}
    assert add_token()
    assert set(get_tokens()) == {"asdfaosdifhasdofi"}
    assert add_token(token="jack")
    assert set(get_tokens()) == {"asdfaosdifhasdofi", "jack"}


def first_nudge_timestamp(client, review_ref):
    return client.document(review_ref).get().to_dict()["_first_nudge_"]


def second_nudge_timestamp(client, review_ref):
    return client.document(review_ref).get().to_dict()["_second_nudge_"]


def assert_time_range_from_now(time, low, high):
    assert time is not None
    assert low <= (_now() - time).total_seconds() <= high


@pytest.fixture
def added_token(client, test_user):
    token = "cqmrjluqr6A:APA91bHsN_uZrPx3NS9bAytG2lWkp46Rm8tr8BRRzbTlgWKTr2MdqfZK0_LGD6PUC6mQFKjRTy6czfWd8pbVkomMQIABO0jAxC1hw_j54jIpc01qLJsbZLkX6sVuIf6dDvivGniUEQZF"
    assert wrap_call("addFCMToken", token=token)()
    return token


@pytest.fixture
def first_nudge(client: gfs.Client, review_ref, added_token):
    client.document(review_ref).update(
        {"published": False, "_extras.created_at": _now() - datetime.timedelta(hours=2)}
    )
    assert first_nudge_timestamp(client, review_ref) is None
    assert second_nudge_timestamp(client, review_ref) is None

    assert call_fn("firstNudge").is_success
    ts = first_nudge_timestamp(client, review_ref)
    assert ts is not None
    assert second_nudge_timestamp(client, review_ref) is None
    return ts


@pytest.fixture
def second_nudge(client: gfs.Client, review_ref, first_nudge):
    client.document(review_ref).update(
        {"published": False, "_first_nudge_": _now() - datetime.timedelta(days=2)}
    )
    assert call_fn("secondNudge").is_success
    return second_nudge_timestamp(client, review_ref)


def test_first_nudge(client, first_nudge):
    assert_time_range_from_now(first_nudge, 0, 4)
    notification = list(client.collection("notifications").stream())[0].reference
    operations = lambda: list(notification.collection("operations").stream())
    count = 0
    max_count = 30
    while not operations():
        print(max_count - count)
        time.sleep(1)
        count += 1
        if count == max_count:
            pytest.fail()


def test_second_nudge(second_nudge):
    assert_time_range_from_now(second_nudge, 0, 4)


def test_nudge_published(client: gfs.Client, review_ref, added_token):
    client.document(review_ref).update(
        {"published": True, "_extras.created_at": _now() - datetime.timedelta(hours=2)}
    )
    assert call_fn("firstNudge").is_success
    assert first_nudge_timestamp(client, review_ref) is None


def test_nudge_too_early(client: gfs.Client, review_ref, added_token):
    client.document(review_ref).update(
        {
            "published": False,
            "_extras.created_at": _now() - datetime.timedelta(minutes=45),
        }
    )
    assert call_fn("firstNudge").is_success
    assert first_nudge_timestamp(client, review_ref) is None


def test_nudge_repeat(client: gfs.Client, review_ref, first_nudge):
    assert call_fn("firstNudge").is_success
    assert first_nudge == first_nudge_timestamp(client, review_ref)


def test_second_nudge_repeat(client: gfs.Client, review_ref, second_nudge):
    assert call_fn("secondNudge").is_success
    assert second_nudge == second_nudge_timestamp(client, review_ref)


def _box(a, b, c, d):
    return {"lo": {"lat": a, "lng": b}, "hi": {"lat": c, "lng": d}}


def test_map_search(client, discover_index):
    discover_index.clear_objects()
    discover_index.save_objects(
        [
            {
                "objectID": "restaurants/standard",
                "_tags": ["restaurants"],
                "_geoloc": {"lat": 0, "lng": 0},
                "name": "Cafe",
            },
            {
                "objectID": "restaurants/pizza",
                "_tags": ["restaurants"],
                "_geoloc": {"lat": 0, "lng": 0},
                "name": "Pizza",
            },
            {
                "objectID": "restaurants/dish",
                "_tags": ["dishes"],
                "_geoloc": {"lat": 0, "lng": 0},
                "name": "Bagel",
            },
            {
                "objectID": "restaurants/lng2",
                "_tags": ["restaurants"],
                "_geoloc": {"lat": 0, "lng": 2},
                "name": "Cafe",
            },
        ]
    )
    time.sleep(3)
    box_all = _box(0, 0, 0, 2)
    box_0 = _box(0, 0, 0, 1)
    box_2 = _box(0, 1, 0, 2)
    box_none = _box(0, 3, 0, 4)

    oids = lambda result: {r["objectID"].split("/")[-1] for r in result.val}

    search = wrap_call("searchMapForRestaurants", only_success=False)

    assert oids(search()) == {"standard", "pizza", "lng2"}
    assert oids(search(box=box_all)) == {"standard", "pizza", "lng2"}
    assert oids(search(box=box_0)) == {"standard", "pizza"}
    assert oids(search(box=box_2)) == {"lng2"}
    assert oids(search(box=box_none)) == set()
    assert oids(search(term="cafe")) == {"standard", "lng2"}
    assert oids(search(term="cafe", box=box_2)) == {"lng2"}
    assert oids(search(term="pizza", box=box_2)) == set()
    assert oids(search(term="pizza", box=box_0)) == {"pizza"}


def test_delete_review_with_bookmarks(review_ref, bookmark_ref, client):
    def n_bookmarks():
        bookmarks = list(client.document(review_ref).collection("bookmarks").stream())
        print([bookmark.reference.path for bookmark in bookmarks])
        return len(bookmarks)

    assert n_bookmarks() > 0
    assert wrap_call("deleteReview", review=review_ref)()
    count = 0
    while n_bookmarks() > 0:
        time.sleep(1)
        print(f"tick {10 - count}")
        count += 1
        if count > 10:
            pytest.fail("Bookmarks never decreased")


def test_delete_review_with_comments(review_ref, comment_ref, client):
    def n_comments():
        comments = list(client.document(review_ref).collection("comments").stream())
        print([comment.reference.path for comment in comments])
        return len(comments)

    assert n_comments() > 0
    assert wrap_call("deleteReview", review=review_ref)()
    count = 0
    while n_comments() > 0:
        time.sleep(1)
        print(f"tick {10 - count}")
        count += 1
        if count > 10:
            pytest.fail("comments never decreased")


def test_bookmark_notification(added_token, review_ref, client):
    n_messages = lambda: len(list(client.collection("fake_notifications").stream()))
    wrap_call("publishReview", review=review_ref)()
    assert n_messages() == 0
    bookmark_ref = _create_bookmark(review_ref)
    count = 0
    max_count = 30
    while not n_messages():
        time.sleep(1)
        print(f"tick {max_count - count}")
        count += 1
        if count > max_count:
            pytest.fail("Never got notification")


def test_follow_notification(added_token, test_user, client):
    n_messages = lambda: len(list(client.collection("fake_notifications").stream()))
    assert n_messages() == 0
    assert len(list(test_user.collection("followers").stream())) == 0
    test_user.collection("followers").add({"user": test_user})
    assert len(list(test_user.collection("followers").stream())) == 1
    assert (
        list(test_user.collection("followers").stream())[0].to_dict()["user"]
        == test_user
    )

    count = 0
    while not n_messages():
        time.sleep(1)
        print(f"tick {10 - count}")
        count += 1
        if count > 10:
            pytest.fail("Never got notification")


def test_reserve(client):
    username = "jacko"
    email = "j@j.com"
    referral_code = "asdf"

    def add_code(code):
        client.collection("referral_codes").document().set({"referral_code": code})

    reserve = wrap_call(
        "reserveUsername", username=username, email=email, referral_code=referral_code
    )
    get = lambda: list(client.collection("reservations").stream())

    assert not reserve()
    assert len(get()) == 0
    add_code(referral_code)
    assert reserve()
    assert len(get()) == 1
    assert get()[0].to_dict() == {
        "username": username,
        "email": email,
        "referral_code": referral_code,
    }
    assert not reserve()
    assert not reserve(email="different", referral_code="different2")
    assert not reserve(username="different", referral_code="different2")
    assert not reserve(
        username="different",
        referral_code="different2",
        email="different@different.com",
    )
    add_code("different2")
    assert reserve(
        username="different",
        referral_code="different2",
        email="different@different.com",
    )
    assert len(get()) == 2


def test_pay(test_user, other_user, client: gfs.Client):
    payments = lambda: list(client.collection("payments").stream())
    assert len(payments()) == 0
    pay = wrap_call(
        "pay", **{"from": test_user.path, "to": other_user.path, "amount_cents": 102}
    )
    assert pay()
    _payments = payments()
    assert len(_payments) == 1
    d = _payments[0].to_dict()
    assert "created_at" in d.pop("_extras")
    assert d == {"from": test_user, "to": other_user, "amount_cents": 102}


def test_pay(test_user, other_user, client: gfs.Client):
    payments = lambda: list(client.collection("payments").stream())
    assert len(payments()) == 0
    pay = wrap_call(
        "pay", **{"from": test_user.path, "to": other_user.path, "amount_cents": 102}
    )
    assert pay()
    _payments = payments()
    assert len(_payments) == 1
    d = _payments[0].to_dict()
    assert "created_at" in d.pop("_extras")
    assert d == {"from": test_user, "to": other_user, "amount_cents": 102}


def test_create_referral_link(
    client: gfs.Client, review_ref, resto_ref, other_user_review_ref
):
    create = wrap_call("createReferralLink", review=review_ref, only_success=False)
    deals = lambda: list(client.document(resto_ref).collection("deals").stream())
    links = lambda: list(client.collection("referral_links").stream())
    assert len(links()) == 0
    assert len(deals()) == 0
    c = create()
    assert c.is_success
    val = c.val
    l = links()
    assert len(l) == 1
    assert len(deals()) == 1
    assert l[0].to_dict()["review"].path == review_ref
    assert l[0].to_dict()["_extras"]["created_at"]
    doc_id = l[0].reference.id
    c = create()
    assert c.is_success
    assert c.val == val
    assert len(links()) == 1
    assert len(deals()) == 1
    assert create(review=other_user_review_ref.path).val != val
    assert len(links()) == 2
    assert len(deals()) == 1


@pytest.fixture
def referral_link_ref(review_ref, client):
    wrap_call("createReferralLink", review=review_ref)()
    return list(client.collection("referral_links").stream())[0].reference


@pytest.fixture
def qr_code_ref(referral_link_ref, test_user, client):
    wrap_call("generateQR", referral=referral_link_ref.path, only_success=False,)()
    return list(referral_link_ref.collection("qr_codes").stream())[0].reference


def test_generate_qr(client: gfs.Client, referral_link_ref, other_user):
    create = wrap_call(
        "generateQR", referral=referral_link_ref.path, only_success=False,
    )
    qrs = lambda: list(referral_link_ref.collection("qr_codes").stream())
    assert len(qrs()) == 0
    c = create()
    assert c.is_success
    val = c.val
    qr = qrs()[0]
    assert qr.reference.path == val["reference"]
    c = create()
    assert c.val == val
    assert len(qrs()) == 1
    c = create(__test_user__=other_user.id)
    assert len(qrs()) == 2
    assert c.is_success
    assert c.val != val


def test_scan(qr_code_ref, client: gfs.Client, test_user, resto_ref):
    scan = wrap_call(
        "scan", code=qr_code_ref.path, order_amount_cents=240, only_success=False
    )
    scans = lambda: list(qr_code_ref.collection("scans").stream())
    deals = lambda: list(client.document(resto_ref).collection("deals").stream())

    assert not scan().is_success

    client.document(resto_ref).update({"merchant": test_user})

    assert len(deals()) == 1
    s = scan()
    assert s.is_success
    v = s.val
    print(v)
    assert v.pop("user")["reference"] == test_user.path
    d = deals()
    assert len(d) == 1
    print(d[0].to_dict())
    assert v.pop("deal") == d[0].reference.path
    assert v.pop("scan") == scans()[0].reference.path
    assert v.pop("promotional_text") == ""
    assert v.pop("promotional_offer") == ""
    assert v == {"order_amount_cents": 240, "discount_amount_cents": 24}
    s = scans()
    assert len(s) == 1
    s_dict = s[0].to_dict()
    assert len(s_dict.pop("_extras")) > 0
    assert scan().is_success
    assert len(scans()) == 2
    assert len(deals()) == 1
    assert s_dict == {
        "deal": d[0].reference,
        "order_amount_cents": 240,
        "discount_amount_cents": 24,
        "discount_amount_percentage": 10,
        "restaurant": client.document(resto_ref),
        "kickback_cents": 100,
        "kickback_user": test_user,
        "merchant": test_user,
        "promotional_text": "",
        "promotional_offer": "",
        "user": test_user,
        "verified": False,
    }


def test_batch_count(
    client,
    comment_ref,
    review_ref,
    dish_ref,
    resto_ref,
    bookmark_ref,
    other_user,
    other_user_review_ref,
    test_user,
):
    other_user_review_ref = other_user_review_ref.path
    assert (
        next(
            iter(client.document(review_ref).collection("bookmarks").stream())
        ).reference.path
        == bookmark_ref
    )
    call = wrap_call("batchUpdateCountsCallFn", only_success=False)
    like = wrap_call("likeCommentOrReview")
    status = call()
    assert status.is_success
    assert status.val == {
        review_ref: {"comment": 1, "bookmark": 1},
        dish_ref: {"up": 1, "down": 1},
        resto_ref: {"up": 1, "down": 1},
    }
    assert like(comment_or_review=review_ref)
    status = call()
    assert status.is_success
    assert status.val == {
        review_ref: {"comment": 1, "bookmark": 1, "up": 1},
        dish_ref: {"up": 1, "down": 1},
        resto_ref: {"up": 1, "down": 1},
    }
    assert like(comment_or_review=comment_ref)
    status = call()
    assert status.is_success
    assert status.val == {
        review_ref: {"comment": 1, "bookmark": 1, "up": 1},
        dish_ref: {"up": 1, "down": 1},
        resto_ref: {"up": 1, "down": 1},
        comment_ref: {"up": 1},
    }
    assert like(comment_or_review=comment_ref, __test_user__=other_user.id)
    status = call()
    assert status.is_success
    assert status.val == {
        review_ref: {"comment": 1, "bookmark": 1, "up": 1},
        dish_ref: {"up": 1, "down": 1},
        resto_ref: {"up": 1, "down": 1},
        comment_ref: {"up": 2},
    }
    assert like(comment_or_review=other_user_review_ref)
    status = call()
    assert status.is_success
    assert status.val == {
        review_ref: {"comment": 1, "bookmark": 1, "up": 1},
        other_user_review_ref: {"up": 1},
        dish_ref: {"up": 1, "down": 1},
        resto_ref: {"up": 1, "down": 1},
        comment_ref: {"up": 2},
    }
    assert call_fn("follow", {"user": other_user.path}).is_success
    status = call()
    assert status.is_success
    assert status.val == {
        review_ref: {"comment": 1, "bookmark": 1, "up": 1},
        other_user_review_ref: {"up": 1},
        dish_ref: {"up": 1, "down": 1},
        resto_ref: {"up": 1, "down": 1},
        comment_ref: {"up": 2},
        test_user.path: {"following": 1},
        other_user.path: {"follower": 1},
    }


def test_email_create(client):
    mail = lambda: list(client.collection("main").stream())
    assert not mail()
    payload = {"some": {"deep": 3, "paylo": "ad"}}
    assert call_fn("emailSignUp", payload).is_success
    assert mail()[0].to_dict() == {
        "to": ["team@trytaste.app"],
        "toUids": [],
        "message": {"subject": "New Email Signup", "text": json.dumps(payload)},
    }


def test_dedupe_fb_place_id_on_create(client):
    def create(fb_place_id):
        result = wrap_call(
            "createRestaurant",
            name="hi",
            location={"lat": 10, "lng": 11},
            only_success=False,
        )(fb_place_id=fb_place_id)
        assert result.is_success
        ref = result.val["reference"]
        assert ref
        return ref

    n_restos = lambda: len(list(client.collection("restaurants").stream()))

    assert n_restos() == 0
    resto_a = create(fb_place_id="a")
    assert n_restos() == 1
    resto_b = create(fb_place_id="b")
    assert resto_a != resto_b
    assert n_restos() == 2
    resto_blank = create(fb_place_id="")
    assert n_restos() == 3
    assert resto_blank != resto_a
    resto_b_again = create(fb_place_id="b")
    assert n_restos() == 3
    assert resto_b_again == resto_b
    resto_a_again = create(fb_place_id="a")
    assert n_restos() == 3
    assert resto_a_again == resto_a
    resto_null = create(fb_place_id=None)
    assert n_restos() == 4
    assert resto_null != resto_blank


def test_delete_dish_on_no_reviews(client, review_ref, dish_ref, resto_ref):
    user_photo_ref = client.document(review_ref).get().to_dict()["photo"]

    def exists():
        return (
            user_photo_ref.get().exists
            or client.document(dish_ref).get().exists
            or client.document(resto_ref).get().exists
        )

    assert exists()
    client.document(review_ref).delete()
    count = 0
    while exists():
        time.sleep(1)
        print(f"tick {20 - count}")
        count += 1
        if count > 20:
            pytest.fail("Dish and/or resto not deleted")


def test_create_review_cache(client, review_ref, dish_ref, resto_ref):
    def cache_exists():
        review = client.document(review_ref).get().to_dict()
        if "_cache" not in review:
            return False
        cache = review["_cache"]
        resto_location = (
            client.document(resto_ref).get().to_dict()["attributes"]["location"]
        )
        return (
            cache["dish"].path == dish_ref
            and cache["restaurant"].path == resto_ref
            and cache["restaurant_location"] == resto_location
        )

    count = 0
    print("")
    while not cache_exists():
        time.sleep(1)
        print(f"tick {20 - count}")
        count += 1
        if count > 20:
            pytest.fail("Trigger created incorrect or no cache")


def test_change_restaurant_updates_review_cache(
    client, review_ref, dish_ref, resto_ref, other_user_review_ref
):
    other_user_review_ref = other_user_review_ref.path

    def cache_exists():
        return "_cache" in client.document(review_ref).get().to_dict()

    count = 0
    print("\nWaiting for review cache...")
    while not cache_exists():
        time.sleep(1)
        print(f"tick {20 - count}")
        count += 1
        if count > 20:
            pytest.fail("Failure to create cache")

    newLocation = firestore.GeoPoint(1.0, 2.0)

    def location_updated():
        def check(review_ref):
            review = client.document(review_ref).get().to_dict()
            cache = review["_cache"]
            return (
                cache["dish"].path == dish_ref
                and cache["restaurant"].path == resto_ref
                and cache["restaurant_location"] == newLocation
            )

        return all(map(check, [review_ref, other_user_review_ref]))

    restaurant = client.document(resto_ref)
    restaurant.update({"attributes.location": newLocation})

    count = 0
    print("\nWaiting for review update...")
    while not location_updated():
        time.sleep(1)
        print(f"tick {20 - count}")
        count += 1
        if count > 20:
            pytest.fail("Failure to update cache")


def test_create_bug_report(client, photo_ref):
    result = call_fn(
        "createBugReport", {"text": "Bug report text.", "bug_photos": [photo_ref.path]}
    )

    report = client.document(result.val["reference"]).get().to_dict()
    assert report["text"] == "Bug report text."
    assert len(report["bug_photos"]) == 1


def test_favorites(client, test_user, resto_ref):
    result = call_fn("addFavorite", {"restaurant": resto_ref})
    favorite_record = client.document(result.val["reference"]).get().to_dict()
    assert favorite_record["user"] == test_user.path
    user_favorite_records = list(test_user.collection("favorites").stream())
    assert len(user_favorite_records) == 1
    assert user_favorite_records[0].to_dict()["restaurant"] == resto_ref
    # Test removing favorite.
    call_fn("removeFavorite", {"restaurant": resto_ref})
    restaurant_favorite_records = list(
        client.document(resto_ref).collection("favorites").stream()
    )
    user_favorite_records = list(test_user.collection("favorites").stream())
    assert len(user_favorite_records) == 0
    assert len(restaurant_favorite_records) == 0


def test_metrics_get_tsa(review_ref, dish_ref, resto_ref):
    result = direct_call_fn("metrics_get_tsa", {})["result"]
    assert len(result) == 1  # One day of data
    assert result[0]["tsa"] == 1  # 1 review.

    like = wrap_call("likeCommentOrReview")
    comment = wrap_call("addComment", text="good comment", review=review_ref)
    bookmark = wrap_call("bookmark", reference=review_ref)

    like(comment_or_review=review_ref)
    comment()
    bookmark()
    result = direct_call_fn("metrics_get_tsa", {})["result"]
    assert len(result) == 1  # One day of data
    assert result[0]["tsa"] == 4  # +like, +bookmark, +comment

    comment_ref = call_fn("addComment", {"text": "good", "review": review_ref}).ref
    like(comment_or_review=comment_ref)
    result = direct_call_fn("metrics_get_tsa", {})["result"]
    assert len(result) == 1  # One day of data
    assert result[0]["tsa"] == 6  # +comment, +comment-like


def test_review_counts(client, dish_ref, resto_ref, review_ref):
    count = (
        lambda: client.document(resto_ref)
        .get()
        .to_dict()
        .get("counts", {})
        .get("up", 0)
    )
    while count() < 1:
        print("1", count())
        time.sleep(1)
    client.document(review_ref).delete()
    while count() != 0:
        print("0", count())
        time.sleep(1)
    for _ in range(10):
        assert count() == 0
        print("0", count())
        time.sleep(1)


def test_top_review(client, dish_ref, resto_ref, review_ref):
    def top_review():
        try:
            return list(
                client.collection("algolia_records")
                .where("object_id", "==", f"restaurantMarker {resto_ref}")
                .stream()
            )[0].to_dict()["payload"]["top_review"]["photo"]
        except:
            return False

    def resto_count():
        return client.document(resto_ref).get().to_dict().get("counts", {}).get("up", 0)

    while top_review() != "fake-photo.png":
        print(top_review(), resto_count())
        time.sleep(1)
    client.document(review_ref).delete()
    while top_review() == "fake-photo.png":
        print(top_review(), resto_count())
        time.sleep(1)


def test_user_photo_algolia(client, review_ref, resto_ref, test_user):
    def photo():
        try:
            return list(
                client.collection("algolia_records")
                .where("object_id", "==", f"restaurantMarker {resto_ref}")
                .stream()
            )[0].to_dict()["payload"]["top_review"]["user"]["thumbnail"]
        except:
            return False

    test_user.update(
        {"vanity.photo": list(test_user.collection("photos").stream())[0].reference}
    )
    client.document(resto_ref).update({"blah": True})
    while photo() != "fake-photo.png":
        print(photo())
        time.sleep(1)


def test_algolia_user(client, test_user):
    count = lambda: len(list(client.collection("algolia_records").stream()))
    while not count():
        print(count())
        time.sleep(1)
    test_user.delete()
    while count():
        print(count())
        time.sleep(1)


def test_algolia_restaurant(client, resto_ref):
    count = lambda: len(list(client.collection("algolia_records").stream()))
    while count() != 2:
        print(count())
        time.sleep(1)
    client.document(resto_ref).delete()
    while count():
        print(count())
        time.sleep(1)


def test_algolia_dish(client, dish_ref):
    count = lambda: len(list(client.collection("algolia_records").stream()))
    while count() != 3:
        print(count())
        time.sleep(1)
    client.document(dish_ref).delete()
    while count() != 2:
        print(count())
        time.sleep(1)


def test_favorite_restaurant_marker(client, resto_ref,test_user):
    test_user.update(
        {"vanity.photo": list(test_user.collection("photos").stream())[0].reference}
    )
    client.document(resto_ref).collection("favorites").add({"user": test_user})

    def photo():
        try:
            return list(
                client.collection("algolia_records")
                .where("object_id", "==", f"restaurantMarker {resto_ref}")
                .stream()
            )[0].to_dict()["payload"]["top_review"]["user"]["thumbnail"]
        except:
            return False

    client.document(resto_ref).update({"blah": True})
    while photo() != "fake-photo.png":
        print(photo())
        time.sleep(1)


def test_algolia_referral_link(client, referral_link_ref, resto_ref):
    location = client.document(resto_ref).get().to_dict()["attributes"]["location"]
    object_id = f"referralLink {referral_link_ref.path}"
    print(object_id)
    ids = lambda: {
        x.to_dict()["object_id"] for x in client.collection("algolia_records").stream()
    }
    while object_id not in ids():
        print(ids())
        time.sleep(1)
    record = list(
        client.collection("algolia_records")
        .where("object_id", "==", object_id)
        .stream()
    )[0]
    record_dict = record.to_dict()
    record_location = record_dict.pop('location')
    assert record_location == location
    assert record_dict == {
        "index": "referrals",
        "reference": referral_link_ref,
        "payload": {
            "user_name": "Jack Daniel Reilly",
            "restaurant_name": "jacko resto",
            "review_photo": "fake-photo.png",
            "user_photo": "https://superphoto",
            "user_username": "jdrusername",
            "dish_name": "jacko dish",
            "review_text": "great review",
            "deal": {
                "promotional_offer": "",
                "promotional_text": "",
                "discount_amount_cents": 0,
            },
        },
        "object_id": f"referralLink {referral_link_ref.path}",
        "record_type": "referralLink",
        "tags": ["referral_link"],
    }

    assert "dish_name" in record.to_dict()["payload"]
    assert "dishName" not in record.to_dict()["payload"]
    referral_link_ref.delete()
    while object_id in ids():
        print(ids())
        time.sleep(1)

def test_update_review_dish_same(review_ref, dish_ref, resto_ref, client):
    def update():
        return call_fn("updateReview", {"text": "updated-text", "reaction": "down",
                                        "review": review_ref, "dish": "jacko dish"})
    
    def get():
        result = client.document(review_ref).get()
        assert result.exists

    update()
    get()

def test_update_review_dish_change(review_ref, dish_ref, resto_ref, client):
    def update():
        return call_fn("updateReview", {"text": "updated-text", "reaction": "down",
                                        "review": review_ref, "dish": "updated-dish"})
    
    def get_dish():
        result = client.document(dish_ref).get()
        print(result.to_dict())
        assert result.exists
        return result

    update()
    updated_dish = get_dish()
    assert updated_dish.to_dict()["attributes"]["name"] == "updated-dish"

def test_update_review_new_dish(review_ref, dish_ref, resto_ref, photo_ref, client):
    def update():
        return call_fn("updateReview", {"text": "updated-text", "reaction": "down",
                                        "review": review_ref, "dish": "updated-dish"})
    
    def get():
        result = client.document(review_ref).get()
        assert not result.exists

    _create_review(dish_ref, client, photo_ref)

    new_review = update().val

    result = client.document(new_review).get().to_dict()
    assert client.document(new_review).parent.parent.path != dish_ref.path

def test_restaurant_reviewers(review_ref, dish_ref, resto_ref, photo_ref, client):
    time.sleep(20)
    
    result = client.document(resto_ref).get().to_dict()
    assert len(result['reviews']) == 1

    other_review = _create_review(dish_ref, client, photo_ref)
    time.sleep(20)

    result = client.document(resto_ref).get().to_dict()
    assert len(result['reviews']) == 2

    client.document(other_review).delete()
    time.sleep(20)

    result = client.document(resto_ref).get().to_dict()
    assert len(result['reviews']) == 1

    client.document(review_ref).delete()
    time.sleep(20)

    result = client.document(resto_ref).get().to_dict()
    assert result['reviews'] == []
