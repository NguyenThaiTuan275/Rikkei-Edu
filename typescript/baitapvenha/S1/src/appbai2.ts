let input1: string = "banana"
let input2: string = "hello world"

input1 = Array.from(new Set(input1.split(''))).toString();

console.log(input1);

