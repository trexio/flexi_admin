# frozen_string_literal: true

require "spec_helper"

RSpec.describe FlexiAdmin::Models::Struct do
  describe ".new" do
    context "with positional attributes" do
      let(:person_class) { FlexiAdmin::Models::Struct.new(:name, :age) }

      it "creates a class with the specified attributes" do
        person = person_class.new("John", 30)
        expect(person.name).to eq("John")
        expect(person.age).to eq(30)
      end

      it "raises an error when given too many arguments" do
        expect { person_class.new("John", 30, "extra") }.to raise_error(ArgumentError, /wrong number of arguments/)
      end

      it "raises an error when omitting arguments" do
        expect do
          person_class.new("John")
        end.to raise_error(ArgumentError, /wrong number of arguments \(given 1, expected 2\)/)
      end

      it "allows creating an instance with the correct number of arguments" do
        person = person_class.new("John", 30)
        expect(person.name).to eq("John")
        expect(person.age).to eq(30)
      end
    end

    context "with keyword attributes" do
      let(:car_class) { FlexiAdmin::Models::Struct.new(make: "Unknown", model: nil, year: 2000) }

      it "creates a class with the specified attributes and default values" do
        car = car_class.new(model: "Civic", year: 2022)
        expect(car.make).to eq("Unknown")
        expect(car.model).to eq("Civic")
        expect(car.year).to eq(2022)
      end

      it "uses default values when not provided" do
        car = car_class.new
        expect(car.make).to eq("Unknown")
        expect(car.model).to be_nil
        expect(car.year).to eq(2000)
      end

      it "raises an error for unknown keyword arguments" do
        expect { car_class.new(color: "Red") }.to raise_error(ArgumentError, /unknown keywords: color/)
      end
    end

    context "with both positional and keyword attributes" do
      let(:book_class) { FlexiAdmin::Models::Struct.new(:title, :author, pages: 0, genre: "Unknown") }

      it "creates a class with both types of attributes" do
        book = book_class.new("1984", "George Orwell", pages: 328, genre: "Dystopian")
        expect(book.title).to eq("1984")
        expect(book.author).to eq("George Orwell")
        expect(book.pages).to eq(328)
        expect(book.genre).to eq("Dystopian")
      end

      it "uses default values for keyword attributes when not provided" do
        book = book_class.new("To Kill a Mockingbird", "Harper Lee")
        expect(book.title).to eq("To Kill a Mockingbird")
        expect(book.author).to eq("Harper Lee")
        expect(book.pages).to eq(0)
        expect(book.genre).to eq("Unknown")
      end

      it "raises an error when positional arguments are missing" do
        expect { book_class.new("1984") }.to raise_error(ArgumentError) do |error|
          expect(error.message).to match(/wrong number of arguments/)
          expect(error.message).to include("given 1, expected 2")
        end
      end
    end
  end

  describe "created class" do
    let(:person_class) { FlexiAdmin::Models::Struct.new(:name, :age) }

    it "creates unique classes for each invocation" do
      another_person_class = FlexiAdmin::Models::Struct.new(:name, :age)
      expect(person_class).not_to eq(another_person_class)
    end

    it "does not respond to class methods of MyStruct" do
      expect(person_class).not_to respond_to(:sex)
    end

    it "creates instances that are not MyStruct instances" do
      person = person_class.new("Alice", 25)
      expect(person).not_to be_a(FlexiAdmin::Models::Struct)
    end
  end
end
