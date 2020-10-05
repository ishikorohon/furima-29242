require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    it "全ての情報が正しいフォーマットで入力されていれば商品出品ができる" do
      @item = FactoryBot.build(:user)
      expect(@item).to be_valid
    end

    it "商品名が空だと登録できない" do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it "商品の説明が空だと登録できない" do
      @item.description = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Descriptiont can't be blank")
    end

    it "カテゴリー欄が空だと登録できない" do
      @item.category = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 1")
    end

    it "商品の状態の欄が空だと登録できない" do
      @item.status = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 1")
    end

    it "配送料の負担についての欄が空だと登録できない" do
      @item.delivery = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery must be other than 1")
    end

    it "発送元の地域の欄が空だと登録できない" do
      @item.prefecture_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
    end

    it "発送までの日数が空だと登録できない" do
      @item.send_time_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Send time must be other than 1")
    end

    it "販売価格が空だと登録できない" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it "299円以下の場合出品できない" do
      @item.price = 100
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it "10000000円以上の場合出品できない" do
      @item.price = 10000001
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end

    it "画像が空だと登録出品できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
  end
end