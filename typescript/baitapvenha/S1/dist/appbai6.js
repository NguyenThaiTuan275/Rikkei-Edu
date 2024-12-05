"use strict";
function game() {
    const n = 5;
    const input = prompt("Nhập số:");
    if (input === null) {
        alert("Trò chơi kết thúc !");
        return;
    }
    const numberInput = parseInt(input);
    if (numberInput === n) {
        alert("Bingo !!!!");
    }
    else if (numberInput > n) {
        alert("Too big !!");
    }
    else {
        alert("Too small !!");
    }
}
