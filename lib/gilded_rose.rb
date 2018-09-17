def update_backstage(item)
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

def update_aged_brie(item)
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

def update_quality(items)
  items.each do |item|
    return item if item.name == 'Sulfuras, Hand of Ragnaros'
    return update_backstage(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
    return update_aged_brie(item) if item.name == 'Aged Brie'

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

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
