"use strict";
function getValues() {
    const num1 = parseFloat(document.getElementById('input1').value);
    const num2 = parseFloat(document.getElementById('input2').value);
    return { num1, num2 };
}
function add() {
    const { num1, num2 } = getValues();
    document.getElementById('result').innerText = `Kết quả: ${num1 + num2}`;
}
function subtract() {
    const { num1, num2 } = getValues();
    document.getElementById('result').innerText = `Kết quả: ${num1 - num2}`;
}
function multiply() {
    const { num1, num2 } = getValues();
    document.getElementById('result').innerText = `Kết quả: ${num1 * num2}`;
}
function divide() {
    const { num1, num2 } = getValues();
    if (num2 === 0) {
        document.getElementById('result').innerText = 'Không thể chia cho 0';
    }
    else {
        document.getElementById('result').innerText = `Kết quả: ${num1 / num2}`;
    }
}
function power() {
    const { num1, num2 } = getValues();
    document.getElementById('result').innerText = `Kết quả: ${Math.pow(num1, num2)}`;
}
function factorial() {
    const num1 = parseInt(document.getElementById('input1').value);
    if (num1 < 0) {
        document.getElementById('result').innerText = 'Không thể tính giai thừa của số âm';
        return;
    }
    let result = 1;
    for (let i = 1; i <= num1; i++) {
        result *= i;
    }
    document.getElementById('result').innerText = `Kết quả: ${result}`;
}
function nthRoot() {
    const { num1, num2 } = getValues();
    if (num2 === 0) {
        document.getElementById('result').innerText = 'Không thể tính căn bậc 0';
    }
    else {
        document.getElementById('result').innerText = `Kết quả: ${Math.pow(num1, 1 / num2)}`;
    }
}
window.add = add;
window.subtract = subtract;
window.multiply = multiply;
window.divide = divide;
window.power = power;
window.factorial = factorial;
window.nthRoot = nthRoot;
