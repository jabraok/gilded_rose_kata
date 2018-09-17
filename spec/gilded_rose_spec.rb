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

  context "Backstage Pass" do
    let(:backstage_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 10) }
    let(:items) { [backstage_pass] }

    it "long before sell date" do
      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 10, quality: 11)
    end

    it "long before sell date at max quality" do
      backstage_pass.quality = 50

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 10, quality: 50)
    end

    it "medium close to sell date upper bound" do
      backstage_pass.sell_in = 10

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 9, quality: 12)
    end

    it "medium close to sell date upper bound at max quality" do
      backstage_pass.sell_in = 10
      backstage_pass.quality = 50

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 9, quality: 50)
    end

    it "medium close to sell date lower bound" do
      backstage_pass.sell_in = 6

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 5, quality: 12)
    end

    it "medium close to sell date lower bound at max quality" do
      backstage_pass.sell_in = 6
      backstage_pass.quality = 50

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 5, quality: 50)
    end

    it "very close to sell date upper bound" do
      backstage_pass.sell_in = 5

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 4, quality: 13)
    end

    it "very close to sell date upper bound at max quality" do
      backstage_pass.sell_in = 5
      backstage_pass.quality = 50

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: 4, quality: 50)
    end

    it "on sell date" do
      backstage_pass.sell_in = 0

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      backstage_pass.sell_in = -10

      update_quality(items)
      expect(backstage_pass).to have_attributes(sell_in: -11, quality: 0)
    end
  end

  context "Normal Item" do
    let(:normal_item) { Item.new('Normal Item', 5, 10) }
    let(:items) { [normal_item] }

    it "before sell date" do
      update_quality(items)
      expect(normal_item).to have_attributes(sell_in: 4, quality: 9)
    end

    it "on sell date" do
      normal_item.sell_in = 0

      update_quality(items)
      expect(normal_item).to have_attributes(sell_in: -1, quality: 8)
    end

    it "after sell date" do
      normal_item.sell_in = -10

      update_quality(items)
      expect(normal_item).to have_attributes(sell_in: -11, quality: 8)
    end

    it "of zero quality" do
      normal_item.quality = 0

      update_quality(items)
      expect(normal_item).to have_attributes(sell_in: 4, quality: 0)
    end
  end

  context "with multiple items" do
    let(:normal_item) { Item.new('Normal Item', 5, 10) }
    let(:aged_brie) { Item.new('Aged Brie', 3, 10) }
    let(:items) { [normal_item, aged_brie] }

    before { update_quality(items) }

    it { expect(normal_item).to have_attributes(sell_in: 4, quality: 9) }
    it { expect(aged_brie).to have_attributes(sell_in: 2, quality: 11) }
  end

  context "Conjured" do
    let(:conjuried) { Item.new('Conjured', 5, 10) }
    let(:items) { [conjuried] }

    it "before sell date" do
      update_quality(items)
      expect(conjuried).to have_attributes(sell_in: 4, quality: 8)
    end

    it "before sell date at zero quality" do
      conjuried.quality = 0

      update_quality(items)
      expect(conjuried).to have_attributes(sell_in: 4, quality: 0)
    end

    it "on sell date" do
      conjuried.sell_in = 0

      update_quality(items)
      expect(conjuried).to have_attributes(sell_in: -1, quality: 6)
    end

    it "on sell date at zero quality" do
      conjuried.sell_in = 0
      conjuried.quality = 0

      update_quality(items)
      expect(conjuried).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      conjuried.sell_in = -10
      conjuried.quality = 10

      update_quality(items)
      expect(conjuried).to have_attributes(sell_in: -11, quality: 6)
    end

    it "after sell date at zero quality" do
      conjuried.sell_in = -10
      conjuried.quality = 0

      update_quality(items)
      expect(conjuried).to have_attributes(sell_in: -11, quality: 0)
    end
  end
end