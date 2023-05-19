# frozen_string_literal: true
require 'rspec'
require_relative 'models/student'

RSpec.describe Student do
  let(:valid_phone) { '+7 (123)-456-78-90' }
  let(:invalid_phone) { '12345' }
  let(:valid_name) { 'Иван' }
  let(:invalid_name) { 'Ivan' }
  let(:valid_account) { '@username' }
  let(:invalid_account) { 'username' }
  let(:valid_email) { 'example@example.com' }
  let(:invalid_email) { 'example@com' }

  describe '.valid_phone?' do
    it 'returns true for a valid phone number' do
      expect(Student.valid_phone?(valid_phone)).to be true
    end

    it 'returns false for an invalid phone number' do
      expect(Student.valid_phone?(invalid_phone)).to be false
    end
  end

  describe '.valid_name?' do
    it 'returns true for a valid name' do
      expect(Student.valid_name?(valid_name)).to be true
    end

    it 'returns false for an invalid name' do
      expect(Student.valid_name?(invalid_name)).to be false
    end
  end

  describe '.valid_account?' do
    it 'returns true for a valid account' do
      expect(Student.valid_account?(valid_account)).to be true
    end

    it 'returns false for an invalid account' do
      expect(Student.valid_account?(invalid_account)).to be false
    end
  end

  describe '.valid_email?' do
    it 'returns true for a valid email' do
      expect(Student.valid_email?(valid_email)).to be true
    end

    it 'returns false for an invalid email' do
      expect(Student.valid_email?(invalid_email)).to be false
    end
  end

  describe '#initialize' do
    it 'sets the instance variables correctly' do
      student = Student.new('Doe', 'John', 'Smith', id: 1, git: '@johndoe', phone: valid_phone, email: valid_email, telegram: '@johndoe')
      expect(student.last_name).to eq('Doe')
      expect(student.first_name).to eq('John')
      expect(student.paternal_name).to eq('Smith')
      expect(student.id).to eq(1)
      expect(student.git).to eq('@johndoe')
      expect(student.phone).to eq(valid_phone)
      expect(student.email).to eq(valid_email)
      expect(student.telegram).to eq('@johndoe')
    end
  end

  # Add more tests for the other methods in the Student class

end
