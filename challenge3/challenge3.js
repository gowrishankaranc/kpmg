function getValueFromNestedObject(object, key) {
  const keys = key.split('/');

  let value = object;
  for (const k of keys) {
    if (value.hasOwnProperty(k)) {
      value = value[k];
    } else {
      return undefined; // Key does not exist in the object
    }
  }

  return value;
}

// Example usage:
const object1 = {"a":{"b":{"c":"d"}}};
const key1 = "a/b/c";
console.log(getValueFromNestedObject(object1, key1)); // Output: "d"

const object2 = {"x":{"y":{"z":"a"}}};
const key2 = "x/y/z";
console.log(getValueFromNestedObject(object2, key2)); // Output: "a"
