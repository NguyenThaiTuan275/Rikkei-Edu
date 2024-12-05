"use strict";
let input1 = "banana";
let input2 = "hello world";
input1 = Array.from(new Set(input1.split(''))).toString();
console.log(input1);
