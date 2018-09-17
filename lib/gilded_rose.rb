class BackstageUpdater
  def self.update(item)
    if item.quality < 50
      item.quality += 1
      if item.sell_in < 11
        if item.quality < 50
          item.quality += 1
        end
      end
      if item.sell_in < 6
        if item.quality < 50
          item.quality += 1
        end
      end
    end

    item.sell_in -= 1

    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end
end

class AgedBrieUpdater
  def self.update(item)
    if item.quality < 50
      item.quality += 1
    end

    item.sell_in -= 1

    if item.sell_in < 0
      if item.quality < 50
        item.quality += 1
      end
    end
  end
end

class NormalUpdater
  def self.update(item)
    if item.quality > 0
      item.quality -= 1
    end

    item.sell_in -= 1

    if item.sell_in < 0
      if item.quality > 0
        item.quality -= 1
      end
    end
  end
end

class SulfurasUpdater
  def self.update(item)
    # Do nothing
  end
end

def update_backstage(item)
  BackstageUpdater.update(item)
end

def update_aged_brie(item)
  AgedBrieUpdater.update(item)
end

def update_normal_item(item)
  NormalUpdater.update(item)
end

def update_sulfuras(item)
  SulfurasUpdater.update(item)
end

def update_quality(items)
  items.each do |item|
    return update_sulfuras(item) if item.name == 'Sulfuras, Hand of Ragnaros'
    return update_backstage(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
    return update_aged_brie(item) if item.name == 'Aged Brie'
    update_normal_item(item)
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
