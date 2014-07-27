require 'rails_helper'

describe WhiteList do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  describe 'email validation' do
    it { is_expected.to allow_value('jchappypig@hotmail.com').for(:email) }
    it { is_expected.to allow_value('hhuang@thoughtworks.com').for(:email) }
    it { is_expected.to allow_value('UPPERCASE@HOTMAIL.COM').for(:email) }
    it { is_expected.not_to allow_value('hhuang@hotmail').for(:email) }
    it { is_expected.not_to allow_value('hhuang.com.hotmail').for(:email) }
    it { is_expected.not_to allow_value('@com.hotmail').for(:email) }
    it { is_expected.not_to allow_value('~~@@@@@@hotmail.com').for(:email) }
    it { is_expected.not_to allow_value('^^&&@hotmail.com').for(:email) }
  end

  describe '#find_by_email_ignore_case' do

    let(:white_list) { create(:white_list) }

    it 'is able to find the white list by email ignore case' do
      expect(WhiteList.find_by_email_ignore_case(white_list.email)).to eq white_list
      expect(WhiteList.find_by_email_ignore_case(white_list.email.capitalize)).to eq white_list
    end

    it 'expects not find the white list if the email address is different' do
      expect(WhiteList.find_by_email_ignore_case('random@email.com')).to be_nil
    end
  end
end
