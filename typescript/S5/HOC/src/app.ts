// Inheritance in OOP
class Animal {
    private type: string;
  
    constructor(type: string) {
      this.type = type;
    }
  
    getType() {
      return this.type;
    }
  
    setType(type: string): void {
      this.type = type;
    }
  
    sound() {
      console.log("This is the animal sound");
    }
  }
  
  class Dog extends Animal {
    private name: string;
    private gender: boolean;
  
    constructor(name: string, gender: boolean) {
      super("carnivore"); 
      this.name = name;
      this.gender = gender;
    }
  
    override sound() {
      super.sound(); 
      console.log("Woof Woof!");
    }
  
    introduce() {
      console.log(
        `This is ${this.name}. I am a ${this.gender ? "male" : "female"} dog.`
      );
    }
  }
  
