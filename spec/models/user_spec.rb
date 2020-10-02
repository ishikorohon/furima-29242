require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '内容に問題ない場合' do
      it "nickname、email、姓、名、誕生日、password、password_confirmationが存在すれば登録できること" do
       expect(@user).to be_valid
      end
    end
    context '内容に問題がある場合' do
    # ニックネーム ---------------------
    it "nicknameが空では登録できないこと" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    #email ---------------------
    it "emailが空では登録できないこと" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "emailが＠がなければ登録できないこと" do
      @user.email = "dddddgmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    # Password ---------------------
    it "passwordが空では登録できないこと" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordが5文字以下の英数字であれば登録できないこと" do
      @user.password = "aa000"
      @user.password_confirmation ="aa000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordが6文字以上でも英数字を含まなければ登録できないこと" do
      @user.password = "000000"
      @user.password_confirmation ="000000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end

    it "passwordが6文字以上でも英数字を含まなければ登録できないこと" do
      @user.password = "aaaaaa"
      @user.password_confirmation ="aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end

    # お名前全角:姓 ---------------------
    it  "お名前(全角):姓が空では登録できないこと" do
      @user.family_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end

    it  "お名前(全角):姓が日本語全角でないとは登録できないこと" do
      @user.family_name = "kana"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name Full-width characters.")
    end

    # お名前全角:名 ---------------------
    it  "お名前(全角):名が空では登録できないこと" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it  "お名前(全角):名が日本語全角でないとは登録できないこと" do
      @user.first_name = "kana"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters.")
    end

    # お名前全角:姓 カナ ---------------------
    it  "お名前カナ(全角):姓が空では登録できないこと" do
      @user.family_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end

    it  "お名前(全角):名が日本語全角でないとは登録できないこと" do
      @user.family_name_kana= "kana"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana Full-width katakana characters.")
    end

    # お名前全角:名 カナ ---------------------
    it  "お名前カナ(全角):名が空では登録できないこと" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it  "お名前(全角):名が日本語全角でないとは登録できないこと" do
      @user.first_name_kana= "kana"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters.")
    end

    # 誕生日 ---------------------
    it  "誕生日が空では登録できないこと" do
      @user.birth_date = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end