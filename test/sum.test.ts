import assert from "node:assert/strict";
import test from "node:test";
import { sum } from "../src/sum.ts";

test("an empty list sums to zero", () => {
  assert.equal(sum([]), 0);
});

test("adds every number", () => {
  assert.equal(sum([2, 3, 5]), 10);
});

test("handles negative numbers and fractions", () => {
  assert.equal(sum([-2, 0.5, 1.5]), 0);
});

test("leaves the input unchanged", () => {
  const numbers = Object.freeze([3, 1, 2]);

  assert.equal(sum(numbers), 6);
  assert.deepEqual(numbers, [3, 1, 2]);
});
