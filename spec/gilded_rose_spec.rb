require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "Aged Brie" do
    let(:aged_brie) { Item.new('Aged Brie', 5, 10) }
    let(:items) { [aged_brie] }

    it "before sell date" do
      update_quality(items)
      expect(aged_brie).to have_attributes(sell_in: 4, quality: 11)
    end

    it "with max quality" do
      aged_brie.quality = 50

      update_quality(items)
      expect(aged_brie).to have_attributes(sell_in: 4, quality: 50)
    end

    it "on sell date" do
      aged_brie.sell_in = 0

      update_quality(items)
      expect(aged_brie).to have_attributes(sell_in: -1, quality: 12)
    end

    it "after sell date" do
      aged_brie.sell_in = -10
      aged_brie.quality = 10

      update_quality(items)
      expect(aged_brie).to have_attributes(sell_in: -11, quality: 12)
    end

    it "after sell date with max quality" do
      aged_brie.sell_in = -10
      aged_brie.quality = 50

      update_quality(items)
      expect(aged_brie).to have_attributes(sell_in: -11, quality: 50)
    end
  end

  context "Sulfuras" do
    let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 5, 80) }
    let(:items) { [sulfuras] }

    it "before sell date" do
      update_quality(items)
      expect(sulfuras).to have_attributes(sell_in: 5, quality: 80)
    end

    it "on sell date" do
      sulfuras.sell_in = 0

      update_quality(items)
      expect(sulfuras).to have_attributes(sell_in: 0, quality: 80)
    end

    it "after sell date" do
      sulfuras.sell_in = -10

      update_quality(items)
      expect(sulfuras).to have_attributes(sell_in: -10, quality: 80)
    end
  end

  # context "with a single item" do
  #   let(:initial_sell_in) { 5 }
  #   let(:initial_quality) { 10 }
  #   let(:name) { "item" }
  #   let(:item) { Item.new(name, initial_sell_in, initial_quality) }

  #   before { update_quality([item]) }

  #   it "your specs here" do
  #     pending
  #   end
  # end

  # context "with multiple items" do
  #   let(:items) {
  #     [
  #       Item.new("NORMAL ITEM", 5, 10),
  #       Item.new("Aged Brie", 3, 10),
  #     ]
  #   }

  #   before { update_quality(items) }

  #   it "your specs here" do
  #     pending
  #   end
  # end
end