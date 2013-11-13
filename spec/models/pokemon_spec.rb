require 'spec_helper'

describe Pokemon do

  describe "#effective_types_against" do
    let(:weaknesses) { subject.effective_types_against }

    context "when it is a dark pokemon" do
      let(:subject) { Pokemon.find_by_name("Absol") }

      %w[ fighting bug fairy ].each do |type|
        it "#{type} is super effective" do
          a_weakness = weaknesses.find {|weakness| weakness.name == type }
          expect(a_weakness).to be
        end
      end
    end

    context "when it is a flying water pokemon" do
      let(:subject) { Pokemon.find_by_name("Gyarados") }

      %w[ electric rock ].each do |type|
        it "#{type} is super effective" do
          a_weakness = weaknesses.find {|weakness| weakness.name == type }
          expect(a_weakness).to be
        end
      end

      %w[ grass ice ].each do |type|
        it "#{type} does standard damage" do
          a_weakness = weaknesses.find {|weakness| weakness.name == type }
          expect(a_weakness).to be_nil
        end
      end
    end
  end

  describe "#ineffective_types_against" do
    let(:resistances) { subject.ineffective_types_against }

    context "when it is a dark pokemon" do
      let(:subject) { Pokemon.find_by_name("Absol") }

      %w[ psychic ghost dark ].each do |type|
        it "#{type} is not effective" do
          a_resistance = resistances.find {|resistance| resistance.name == type }
          expect(a_resistance).to be
        end
      end
    end

    context "when it is a flying water pokemon" do
      let(:subject) { Pokemon.find_by_name("Gyarados") }

      %w[ fire water fighting ground bug steel ].each do |type|
        it "#{type} is not effective" do
          a_resistance = resistances.find {|resistance| resistance.name == type }
          expect(a_resistance).to be
        end
      end

    end
  end
end