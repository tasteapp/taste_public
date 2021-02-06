/// <reference path='../node_modules/mocha-typescript/globals.d.ts' />
import * as firebase from "@firebase/testing";
import * as fs from "fs";

/*
 * ============
 *    Setup
 * ============
 */
const projectId = "firestore-emulator-example";
const coverageUrl = `http://localhost:8080/emulator/v1/projects/${projectId}:ruleCoverage.html`;

const rules = fs.readFileSync(
  "../taste_cloud_functions/firestore.rules",
  "utf8"
);

type App = firebase.firestore.Firestore;

const geo = (lat: number, lng: number) =>
  new firebase.firestore.GeoPoint(lat, lng);

/**
 * Creates a new app with authentication data matching the input.
 *
 * @param {object} auth the object to use for authentication (typically {uid: some-uid})
 * @return {object} the app.
 */
function authedApp(auth) {
  return firebase.initializeTestApp({ projectId, auth }).firestore();
}

const admin = firebase.initializeAdminApp({ projectId }).firestore();

function userDoc(user: string) {
  return admin.doc(`users/${user}`);
}

const createUsers = async (...users: string[]) => {
  const apps = users.map((u) => authedApp({ uid: u }));
  await Promise.all(users.map((u) => create({ path: `users/${u}` })));
  return apps;
};

async function pass<T>(p: Promise<T>): Promise<T> {
  return await firebase.assertSucceeds(p);
}
const fail = firebase.assertFails;
const create = async ({
  path,
  coll,
  app = admin,
  data = {},
}: {
  app?: firebase.firestore.Firestore;
  path?: string;
  coll?: string;
  data?: any;
}) => {
  const doc = coll ? app.collection(coll).doc() : app.doc(path);
  await doc.set(data);
  return doc;
};

/*
 * ============
 *  Test Cases
 * ============
 */
before(async () => {
  await firebase.loadFirestoreRules({ projectId, rules });
});

beforeEach(async () => {
  // Clear the database between tests
  await firebase.clearFirestoreData({ projectId });
});

after(async () => {
  await Promise.all(firebase.apps().map((app) => app.delete()));
  console.log(`View rule coverage information at ${coverageUrl}\n`);
});

@suite
class MyApp {
  @test
  async "user can update only their own profile"() {
    const [alice, bob] = await createUsers("alice", "bob");
    await firebase.assertSucceeds(
      alice
        .collection("users")
        .doc("alice")
        .set({})
    );
    await firebase.assertSucceeds(
      bob
        .collection("users")
        .doc("bob")
        .set({})
    );
    await firebase.assertSucceeds(
      alice
        .collection("users")
        .doc("alice")
        .update({ "vanity.username": "a" })
    );
    await firebase.assertSucceeds(
      bob
        .collection("users")
        .doc("bob")
        .update({ "vanity.username": "b" })
    );
    await firebase.assertFails(
      bob
        .collection("users")
        .doc("alice")
        .update({ "vanity.username": "b" })
    );
  }

  @test
  async "cities is read-only"() {
    await firebase.assertSucceeds(
      admin
        .collection("cities")
        .doc("boston")
        .set({})
    );
    const alice = authedApp({ uid: "alice" });
    await firebase.assertSucceeds(
      alice
        .collection("cities")
        .doc("boston")
        .get()
    );
    await firebase.assertFails(
      alice
        .collection("cities")
        .doc("chicago")
        .set({ a: 1 })
    );
    await firebase.assertFails(
      alice
        .collection("cities")
        .doc("boston")
        .set({ a: 1 })
    );
  }

  @test
  async "toggle likes"() {
    const [alice, bob] = await createUsers("alice", "bob");
    // user record must exist.
    await pass(create({ path: "users/alice", app: alice }));
    await pass(create({ path: "users/bob", app: bob }));
    // parent record must exist.
    await pass(create({ path: "reviews/a" }));
    // index record does not exist.
    await fail(
      create({
        app: alice,
        path: "likes/b",
        data: {
          parent: alice.doc("reviews/a"),
          user: alice.doc("users/alice"),
        },
      })
    );
    const batch = alice.batch();
    const doc = alice.doc("likes/b");
    batch.set(doc, {
      parent: alice.doc("reviews/a"),
      user: alice.doc("users/alice"),
    });
    batch.set(alice.doc("index/likes/parent/reviews/id/a/user/alice"), {
      reference: doc,
    });
    await pass(batch.commit());
    // cannot create the same record
    await (async () => {
      const batch = alice.batch();
      const doc = alice.doc("likes/b");
      batch.set(doc, {
        parent: alice.doc("reviews/a"),
        user: alice.doc("users/alice"),
      });
      batch.set(alice.doc("index/likes/parent/reviews/id/a/user/alice"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // cannot create the same parent/user
    await (async () => {
      const batch = alice.batch();
      const doc = alice.doc("likes/c");
      batch.set(doc, {
        parent: alice.doc("reviews/a"),
        user: alice.doc("users/alice"),
      });
      batch.set(alice.doc("index/likes/parent/reviews/id/a/user/alice"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but mismatch review
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parent/reviews/id/aa/user/bob"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but review DNE
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/aa"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parent/reviews/id/aa/user/bob"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but like record already exists
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/b");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parent/reviews/id/a/user/bob"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but index collection wrong
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likess/parent/reviews/id/a/user/bob"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but parent collection wrong
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parent/reviewss/id/a/user/bob"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but parent tag wrong
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parents/reviews/id/a/user/bob"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but index user wrong
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parent/reviews/id/a/user/bobs"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can, but user field does not match
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/charlie"),
      });
      batch.set(bob.doc("index/likes/parent/reviews/id/a/user/charlie"), {
        reference: doc,
      });
      await fail(batch.commit());
    })();
    // bob can
    await (async () => {
      const batch = bob.batch();
      const doc = bob.doc("likes/c");
      batch.set(doc, {
        parent: bob.doc("reviews/a"),
        user: bob.doc("users/bob"),
      });
      batch.set(bob.doc("index/likes/parent/reviews/id/a/user/bob"), {
        reference: doc,
      });
      await pass(batch.commit());
    })();
  }

  @test
  async "create comments"() {
    const [alice, bob] = await createUsers("alice", "bob");
    // Review DNE
    const text = "hello";
    const _extras = { created_at: new Date(), updated_at: new Date() };
    const user = userDoc("alice");
    const coll = "comments";
    const app = alice;
    await fail(
      create({
        coll,
        app,
        data: {
          parent: alice.doc("reviews/a"),
          user: userDoc("alice"),
          text,
          _extras,
        },
      })
    );
    const review = await create({
      coll: "reviews",
    });
    const parent = review;
    // OK now
    await pass(
      create({
        coll,
        app,
        data: { parent, user, text, _extras },
      })
    );
    // Can create multiple
    await pass(
      create({
        coll,
        app,
        data: { parent, user, text, _extras },
      })
    );
    // But you need the user field
    await fail(
      create({
        coll,
        app,
        data: { parent, text, _extras },
      })
    );
    // And the user field must be you
    await fail(
      create({
        coll,
        app,
        data: { parent, user: userDoc("bob"), text, _extras },
      })
    );
    // Others can create new comments
    const comment = await pass(
      create({
        coll,
        app: bob,
        data: { parent, user: userDoc("bob"), text, _extras },
      })
    );
    // Anyone can read
    await pass(bob.doc(comment.path).get());
    await pass(alice.doc(comment.path).get());
    // Cannot create for something that's not a review
    await fail(
      create({
        coll,
        app: bob,
        data: { parent: user, user: userDoc("bob"), text, _extras },
      })
    );
    const homeMeal = await create({
      coll: "home_meals",
    });
    // But home meals are OK.
    await pass(
      create({
        coll,
        app: bob,
        data: { parent: homeMeal, user: userDoc("bob"), text, _extras },
      })
    );
    // Bad field
    await fail(
      create({
        coll,
        app,
        data: { parent, user, text, _extras, bogus: true },
      })
    );
  }

  @test
  async "update and delete comments"() {
    const [alice, bob] = await createUsers("alice", "bob");
    const parent = await create({
      coll: "reviews",
    });
    const app = alice;
    const user = userDoc("alice");
    const text = "hello";
    const _extras = { created_at: new Date(), updated_at: new Date() };
    const comment = await pass(
      create({
        coll: "comments",
        app: alice,
        data: { parent, user, text, _extras },
      })
    );
    await pass(
      comment.update({ text: "new-text", "_extras.updated_at": new Date() })
    );
    await pass(
      comment.update({
        text: "another-new-text",
        "_extras.updated_at": new Date(),
      })
    );
    await fail(
      bob
        .doc(comment.path)
        .update({ text: "new-text", "_extras.updated_at": new Date() })
    );
    await fail(bob.doc(comment.path).delete());
    await pass(comment.delete());
  }

  @test
  async "update comment fields"() {
    const [alice] = await createUsers("alice", "bob");
    const review = await create({
      coll: "reviews",
    });
    const comment = await pass(
      create({
        coll: "comments",
        app: alice,
        data: {
          parent: review,
          user: userDoc("alice"),
          _extras: { created_at: new Date(), updated_at: new Date() },
          text: "hiii",
        },
      })
    );
    await pass(
      comment.update({ text: "new-text", "_extras.updated_at": new Date() })
    );
    // Empty trimmed string.
    await fail(
      comment.update({ text: "    ", "_extras.updated_at": new Date() })
    );
    // Disallowed field
    await fail(
      comment.update({
        text: "newer-text",
        badField: "bad",
        "_extras.updated_at": new Date(),
      })
    );
    // Bad datatype
    await fail(
      comment.update({ text: 4236326, "_extras.updated_at": new Date() })
    );
  }

  @test
  async notifications() {
    const [alice, bob] = await createUsers("alice", "bob");
    const notification = await create({
      coll: "notifications",
      data: {
        user: userDoc("alice"),
      },
    });
    // Not bob's
    await fail(bob.doc(notification.path).get());
    await fail(bob.doc(notification.path).delete());
    await fail(bob.doc(notification.path).update({ seen: true }));
    // alice's
    await pass(alice.doc(notification.path).get());
    // must be true
    await fail(alice.doc(notification.path).update({ seen: false }));
    // bogus field
    await fail(
      alice.doc(notification.path).update({ seen: true, bogus: true })
    );
    // can't change title
    await fail(
      alice.doc(notification.path).update({ title: "some new title" })
    );
    // wrong datatype
    await fail(alice.doc(notification.path).update({ seen: "asdf" }));
    await pass(alice.doc(notification.path).update({ seen: true }));
    // can't change owner.
    await fail(alice.doc(notification.path).update({ user: userDoc("bob") }));
    await pass(alice.doc(notification.path).update({ user: userDoc("alice") }));
    await pass(alice.doc(notification.path).delete());
  }

  @test
  async "conversation cannot add dupe users"() {
    const [alice] = await createUsers("alice");
    await fail(
      alice
        .collection("conversations")
        .add({ members: ["alice", "alice"].map((p) => userDoc(p)) })
    );
  }

  @test
  async "conversation need at least 2 users"() {
    const [alice, bob] = await createUsers("alice", "bob");
    await fail(
      alice.collection("conversations").add({
        members: ["alice"].map((p) => userDoc(p)),
        _extras: { created_at: new Date(), updated_at: new Date() },
      })
    );
    await pass(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        _extras: { created_at: new Date(), updated_at: new Date() },
      })
    );
  }

  @test
  async "conversation validation"() {
    const [alice, bob] = await createUsers("alice", "bob");
    // bogus field
    await fail(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        bogus: true,
        _extras: { created_at: new Date(), updated_at: new Date() },
      })
    );
    // bogus value
    await fail(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        seen_by: true,
        _extras: { created_at: new Date(), updated_at: new Date() },
      })
    );
    await pass(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        seen_by: [userDoc("alice")],
        _extras: { created_at: new Date(), updated_at: new Date() },
      })
    );
    await pass(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        seen_by: [userDoc("alice")],
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
      })
    );
    await fail(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        seen_by: [userDoc("alice")],
        _extras: {
          created_at: "bad",
          updated_at: new Date(),
        },
      })
    );
  }

  @test
  async "conversation update"() {
    const [alice, bob] = await createUsers("alice", "bob");
    const convo = await pass(
      alice.collection("conversations").add({
        members: ["alice", "bob"].map((p) => userDoc(p)),
        _extras: { created_at: new Date(), updated_at: new Date() },
      })
    );
    await fail(convo.update({ bogus: true }));
    await fail(convo.update({ last_seen: true }));
    await pass(convo.update({ last_seen: { 0: new Date() } }));
    await pass(
      convo.update({
        // Cannot test validation of messages since they're in a repeated field
        messages: firebase.firestore.FieldValue.arrayUnion({ anything: true }),
      })
    );
    await fail(
      convo.update({
        "_extras.created_at": new Date(),
      })
    );
    await pass(
      convo.update({
        "_extras.updated_at": new Date(),
      })
    );
  }

  @test
  async "create conversations"() {
    const [alice, bob, charlie] = await createUsers("alice", "bob", "charlie");
    const createConvo = (app: App, ...participants: string[]) =>
      app.collection("conversations").add({
        members: participants.map((p) => userDoc(p)),
        _extras: { created_at: new Date(), updated_at: new Date() },
      });
    await fail(createConvo(alice, "bob", "charlie"));
    await pass(createConvo(alice, "bob", "alice"));
    const convo = await pass(createConvo(alice, "bob", "alice"));
    await fail(
      convo.update({ members: ["alice", "bob"].map((p) => userDoc(p)) })
    );
    await fail(
      bob
        .doc(convo.path)
        .update({ members: ["alice", "bob"].map((p) => userDoc(p)) })
    );
    await pass(
      bob
        .doc(convo.path)
        .update({ members: ["bob", "alice"].map((p) => userDoc(p)) })
    );
    await pass(
      alice
        .doc(convo.path)
        .update({ members: ["bob", "alice"].map((p) => userDoc(p)) })
    );
    await fail(
      charlie
        .doc(convo.path)
        .update({ members: ["bob", "alice"].map((p) => userDoc(p)) })
    );
  }

  @test
  async "private user document"() {
    const [alice, bob] = await createUsers("alice", "bob");
    const timezone = "Paris";
    const fcm_tokens = firebase.firestore.FieldValue.arrayUnion("token");
    const payload = { timezone, fcm_tokens };
    const options = { merge: true };
    const alicePath = "users/alice/private_documents/private_documents";
    await fail(bob.doc(alicePath).set(payload, options));
    await fail(alice.doc(alicePath).set({ ...payload, junk: true }, options));
    await fail(
      alice.doc(alicePath).set({ ...payload, fcm_tokens: "single" }, options)
    );
    await fail(alice.doc(alicePath).set({ ...payload, timezone: 1 }, options));
    await pass(alice.doc(alicePath).set(payload, options));
    await pass(
      alice.doc(alicePath).set({ ...payload, timezone: "LA" }, options)
    );
    await fail(alice.doc(alicePath).set({ ...payload, timezone: 4 }, options));
    await pass(alice.doc(alicePath).set({ timezone: "Chicago" }, options));
    await fail(alice.doc(alicePath).get());
    await fail(alice.doc(alicePath).delete());
    await fail(bob.doc(alicePath).get());
    await fail(bob.doc(alicePath).delete());
  }

  @test
  async "daily tasty"() {
    const [alice, bob] = await createUsers("alice", "bob");
    const review = await create({
      coll: "reviews",
    });
    const coll = "daily_tasty_votes";
    // Good Alice
    await (async () => {
      const batch = alice.batch();
      const data = {
        date: new Date(),
        post: review,
        user: userDoc("alice"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: 3,
      };
      const doc = alice.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        alice.doc(`index/${coll}/parent/reviews/id/${review.id}/user/alice`),
        {
          reference: doc,
        }
      );
      await pass(batch.commit());
    })();
    // Cannot create again
    await (async () => {
      const batch = alice.batch();
      const data = {
        date: new Date(),
        post: review,
        user: userDoc("alice"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: 3,
      };
      const doc = alice.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        alice.doc(`index/${coll}/parent/reviews/id/${review.id}/user/alice`),
        {
          reference: doc,
        }
      );
      await fail(batch.commit());
    })();
    // Bad score
    await (async () => {
      const batch = bob.batch();
      const data = {
        date: new Date(),
        post: review,
        user: userDoc("bob"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: -1,
      };
      const doc = bob.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        bob.doc(`index/${coll}/parent/reviews/id/${review.id}/user/bob`),
        {
          reference: doc,
        }
      );
      await fail(batch.commit());
    })();
    // Bad score
    await (async () => {
      const batch = bob.batch();
      const data = {
        date: new Date(),
        post: review,
        user: userDoc("bob"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: 10,
      };
      const doc = bob.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        bob.doc(`index/${coll}/parent/reviews/id/${review.id}/user/bob`),
        {
          reference: doc,
        }
      );
      await fail(batch.commit());
    })();
    // Bad score
    await (async () => {
      const batch = bob.batch();
      const data = {
        date: new Date(),
        post: review,
        user: userDoc("bob"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: "asdf",
      };
      const doc = bob.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        bob.doc(`index/${coll}/parent/reviews/id/${review.id}/user/bob`),
        {
          reference: doc,
        }
      );
      await fail(batch.commit());
    })();
    // Bad user
    await (async () => {
      const batch = bob.batch();
      const data = {
        date: new Date(),
        post: review,
        user: userDoc("alice"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: 3,
      };
      const doc = bob.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        bob.doc(`index/${coll}/parent/reviews/id/${review.id}/user/bob`),
        {
          reference: doc,
        }
      );
      await fail(batch.commit());
    })();
    // No date
    await (async () => {
      const batch = bob.batch();
      const data = {
        post: review,
        user: userDoc("bob"),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: 3,
      };
      const doc = bob.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        bob.doc(`index/${coll}/parent/reviews/id/${review.id}/user/bob`),
        {
          reference: doc,
        }
      );
      await fail(batch.commit());
    })();
    // Bob ok
    const vote = await (async () => {
      const batch = bob.batch();
      const data = {
        post: review,
        user: userDoc("bob"),
        date: new Date(),
        _extras: {
          created_at: new Date(),
          updated_at: new Date(),
        },
        score: 3,
      };
      const doc = bob.collection(coll).doc();
      batch.set(doc, data);
      batch.set(
        bob.doc(`index/${coll}/parent/reviews/id/${review.id}/user/bob`),
        {
          reference: doc,
        }
      );
      await pass(batch.commit());
      return doc;
    })();
    // cannot update bad value
    await fail(vote.update({ score: 2, date: new Date(), bogus: true }));
    await fail(vote.update({ score: 10, date: new Date() }));
    await pass(vote.update({ score: 1, date: new Date() }));
    await pass(vote.update({score: 1, date: new Date(), '_extras.updated_at': firebase.firestore.FieldValue.serverTimestamp()}));
    await fail(vote.update({score: 1, date: new Date(), '_extras.updated_at': 'asdf'}));
  }

  @test
  async restaurant() {
    const [alice] = await createUsers("alice");
    const coll = "restaurants";
    const app = alice;
    const location = geo(2, 3);
    const source_location = geo(3, 4);
    const name = "Great name";
    const city = "My City";
    const country = "France";
    const source = "facebook";
    const address = { city, country, source, source_location };
    const fb_place_id = "some-id";
    const categories = [];
    const created_at = new Date();
    const updated_at = new Date();
    const _extras = { created_at, updated_at };
    const attributes = {
      name,
      location,
      address,
      fb_place_id,
      categories,
    };
    const data = { attributes, _extras };
    const args = { app, coll, data };
    await pass(create({ ...args }));
    await pass(create({ ...args }));
    await fail(
      create({
        ...args,
        data: { ...data, _extras: { ..._extras, created_at: 4 } },
      })
    );
    await fail(create({ ...args, data: { ...data, _extras: {} } }));
    await fail(create({ ...args, data: {} }));
    await fail(
      create({
        ...args,
        data: { ...data, attributes: { ...attributes, name: "    " } },
      })
    );
    await fail(
      create({
        ...args,
        data: { ...data, attributes: { ...attributes, name: 4 } },
      })
    );
    await pass(
      create({
        ...args,
        data: { ...data, attributes: { ...attributes, name: "okey" } },
      })
    );
    await fail(
      create({
        ...args,
        data: {
          ...data,
          attributes: {
            ...attributes,
            address: { ...address, source: "bogus" },
          },
        },
      })
    );
    await fail(
      create({
        ...args,
        data: {
          ...data,
          attributes: { ...attributes, address: { ...address, source: null } },
        },
      })
    );
    await pass(
      create({
        ...args,
        data: {
          ...data,
          attributes: {
            ...attributes,
            address: { ...address, source: "facebook" },
          },
        },
      })
    );
    (async () => {
      const { city, ...addressNoCity } = address;
      await fail(
        create({
          ...args,
          data: {
            ...data,
            attributes: { ...attributes, address: addressNoCity },
          },
        })
      );
    })();
    await fail(
      create({
        ...args,
        data: {
          ...data,
          attributes: {
            ...attributes,
            address: { ...address, city: 4 },
          },
        },
      })
    );
    await fail(
      create({
        ...args,
        data: {
          ...data,
          attributes: {
            ...attributes,
            address: { ...address, city: "    " },
          },
        },
      })
    );
    await fail(
      create({
        ...args,
        data: {
          ...data,
          attributes: {
            ...attributes,
            fb_place_id: "   ",
          },
        },
      })
    );
    const resto = await pass(
      create({
        ...args,
        data: {
          ...data,
          attributes: {
            ...attributes,
            fb_place_id: "  asdfasdfa ",
          },
        },
      })
    );
    await fail(resto.update({ bogus: true }));
    await fail(resto.update({ attributes: { name: "change-name" } }));
    await fail(resto.update({ profile_pic_external_url: 42 }));
    await fail(resto.update({ profile_pic_external_url: "     " }));
    await fail(resto.update({ profile_pic_external_url: "not-a-url" }));
    await fail(resto.update({ profile_pic_external_url: " http://stillbad" }));
    await fail(resto.update({ profile_pic_external_url: "htp://bad" }));
    await fail(resto.update({ profile_pic_external_url: "htp://bad" }));
    await fail(resto.update({ profile_pic_external_url: "http:/bad" }));
    await fail(resto.update({ profile_pic_external_url: "http://" }));
    await pass(resto.update({ profile_pic_external_url: "http://goodlink" }));
    await pass(resto.update({ profile_pic_external_url: "https://goodlink" }));
    await pass(
      resto.update({
        profile_pic_external_url:
          "https://scontent-cdt1-1.xx.fbcdn.net/v/t31.0-1/c437.94.1174.1173a/s200x200/412043_513701735331135_266693521_o.jpg?_nc_cat=101&_nc_sid=dbb9e7&_nc_oc=AQnJ8CbSS65rbHsuG44yAEoImzuz89BU6dZ5ZIU6L3MlolU1Gcgw2JUBCKpEYfEjpI44T7RxKO5rzFniLsu-LL01&_nc_ht=scontent-cdt1-1.xx&oh=8f19769b10806479c9c1b14cee8bb628&oe=5EE45F5F",
      })
    );
    // Cannot change both at once
    await fail(
      resto.update({
        profile_pic_external_url: "https://goodlink",
        "attributes.google_place_id": "fdsa",
      })
    );
    // OK
    await pass(resto.update({ "attributes.google_place_id": "fdsa" }));
    // Bad data
    await fail(resto.update({ "attributes.google_place_id": 432 }));
    // Empty
    await fail(resto.update({ "attributes.google_place_id": "  " }));
    // Blows away existing fields
    await fail(resto.update({ attributes: { google_place_id: "fdsa" } }));
    // Modifies unmodifiable field
    await fail(
      resto.update({
        "attributes.google_place_id": "fdsa",
        "attributes.fb_place_id": "asdf",
      })
    );
    // Can't add a junk field as normal user
    await fail(resto.update({ junk: true }));
    // Can as admin
    await pass(admin.doc(resto.path).update({ junk: true }));
    // But you can still update in case there is a junk field
    await pass(resto.update({ profile_pic_external_url: "https://goodlink" }));
  }
}
