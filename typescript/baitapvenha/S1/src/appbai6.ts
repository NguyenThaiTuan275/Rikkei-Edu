function game(): void {
    const n:number = 5;
    const input:string | null = prompt("Nhập số:");

    if (input === null){
        alert("Trò chơi kết thúc !");
        return;
    }

    const numberInput: number = parseInt(input);
    
    if(numberInput === n){
        alert("Bingo !!!!");
    } else if (numberInput > n){
        alert("Too big !!");
    } else {
        alert("Too small !!");
    }
}