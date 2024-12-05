function getValues(): { num1: number, num2: number } {
    const num1 = parseFloat((document.getElementById('input1') as HTMLInputElement).value);
    const num2 = parseFloat((document.getElementById('input2') as HTMLInputElement).value);
    return { num1, num2 };
}

function add(): void {
    const { num1, num2 } = getValues();
    document.getElementById('result')!.innerText = `Kết quả: ${num1 + num2}`;
}

function subtract(): void {
    const { num1, num2 } = getValues();
    document.getElementById('result')!.innerText = `Kết quả: ${num1 - num2}`;
}

function multiply(): void {
    const { num1, num2 } = getValues();
    document.getElementById('result')!.innerText = `Kết quả: ${num1 * num2}`;
}

function divide(): void {
    const { num1, num2 } = getValues();
    if (num2 === 0) {
        document.getElementById('result')!.innerText = 'Không thể chia cho 0';
    } else {
        document.getElementById('result')!.innerText = `Kết quả: ${num1 / num2}`;
    }
}

function power(): void {
    const { num1, num2 } = getValues();
    document.getElementById('result')!.innerText = `Kết quả: ${Math.pow(num1, num2)}`;
}

function factorial(): void {
    const num1 = parseInt((document.getElementById('input1') as HTMLInputElement).value);
    if (num1 < 0) {
        document.getElementById('result')!.innerText = 'Không thể tính giai thừa của số âm';
        return;
    }
    let result = 1;
    for (let i = 1; i <= num1; i++) {
        result *= i;
    }
    document.getElementById('result')!.innerText = `Kết quả: ${result}`;
}

function nthRoot(): void {
    const { num1, num2 } = getValues();
    if (num2 === 0) {
        document.getElementById('result')!.innerText = 'Không thể tính căn bậc 0';
    } else {
        document.getElementById('result')!.innerText = `Kết quả: ${Math.pow(num1, 1 / num2)}`;
    }
}

// Export functions to global scope
(window as any).add = add;
(window as any).subtract = subtract;
(window as any).multiply = multiply;
(window as any).divide = divide;
(window as any).power = power;
(window as any).factorial = factorial;
(window as any).nthRoot = nthRoot;