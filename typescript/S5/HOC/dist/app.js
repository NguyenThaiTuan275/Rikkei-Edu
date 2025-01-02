"use strict";
// Inheritance in OOP
class Animal {
    constructor(type) {
        this.type = type;
    }
    getType() {
        return this.type;
    }
    setType(type) {
        this.type = type;
    }
    sound() {
        console.log("This is the animal sound");
    }
}
class Dog extends Animal {
    constructor(name, gender) {
        super("carnivore");
        this.name = name;
        this.gender = gender;
    }
    sound() {
        super.sound();
        console.log("Woof Woof!");
    }
    introduce() {
        console.log(`This is ${this.name}. I am a ${this.gender ? "male" : "female"} dog.`);
    }
}
