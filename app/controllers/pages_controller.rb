class PagesController < ApplicationController
  include ApplicationHelper
  include ActionView::Helpers::SanitizeHelper

  before_action :verify_authenticity_token, only: :search
  before_action :load_radiator

  def index
  end

  def golos
    @radiator = Radiator::Api.new(url:'https://ws.golos.io')
    @chain = 'golos'
    redirect_back(fallback_location: root_path)
  end

  def steem
    @radiator = Radiator::Api.new(url:'https://api.steemit.com')
    @chain = 'steem'
    redirect_back(fallback_location: root_path)
  end

  def earnings
    if permitted_params[:username]
      raw_posts = SteemApi::Comment.where('created > ? AND depth = 0', Date.today - 30.days).where(author: permitted_params[:username]).order(created: :desc)
      @search_result = ['discussion', raw_posts ? discussion_hash(raw_posts, permitted_params[:username.downcase]) : nil]
    end
    render js: "$('body').spin(false);" if @search_result && @search_result[1] == nil
  end

  def witness
    if permitted_params[:username]
      # TODO: FIXME: FIXME: TODO:
      # raw_posts = @radiator.get_discussions_by_blog({tag:permitted_params[:username].downcase,limit:100}).result
      raw_posts = []
      @search_result = ['discussion', raw_posts ? discussion_hash(raw_posts, permitted_params[:username.downcase]) : nil]
    end
    render js: "$('body').spin(false);" if @search_result && @search_result[1] == nil
  end

  def head_block
    render json: {head_block_num: @radiator.get_dynamic_global_properties.result.head_block_number}
  end

  def search
    case permitted_params[:search].match(/^\d*@/)
    when nil
      raw_tx = @radiator.get_transaction(permitted_params[:search]).result
      @search_result = ['transaction', raw_tx ? tx_hash(raw_tx) : nil]
    else
      raw_block = @radiator.get_block(permitted_params[:search]).result
      @search_result = ['block', raw_block ? block_hash(raw_block) : nil]
    end
    render js: "$('body').spin(false);" if @search_result && @search_result[1] == nil
  end

  private

  def load_radiator
    @radiator ||= Radiator::Api.new(url:'https://api.steemit.com')
    @chain ||= 'steem'
  end

  def permitted_params
    params.permit(:authenticity_token,:search,:username)
  end

  def tx_hash(raw_tx)
    {
      ref_block_num: raw_tx&.ref_block_num,
      ref_block_prefix: raw_tx&.ref_block_prefix,
      expiration: raw_tx&.expiration,
      operations: gen_operations_html(raw_tx&.operations),
      extensions: raw_tx&.extensions,
      signatures: gen_signatures_html(raw_tx&.signatures),
      transaction_id: raw_tx&.transaction_id,
      block_num: raw_tx&.block_num,
      transaction_num: raw_tx&.transaction_num
    }
  end

  def block_hash(raw_block)
    {
      previous: raw_block&.previous,
      timestamp: raw_block&.timestamp,
      witness: raw_block&.witness,
      transaction_merkel_root: raw_block&.transaction_merkel_root,
      extensions: raw_block&.extensions,
      witness_signature: raw_block&.witness_signature,
      transactions: gen_transactions_html(raw_block&.transactions),
      block_id: raw_block&.block_id,
      signing_key: raw_block&.signing_key,
      transaction_ids: raw_block&.transaction_ids
    }
  end

  def discussion_hash(discussions, author)
    votes_array = gen_votes_array(discussions, author)
    {
      discussions_html: gen_discussions_html(discussions, author),
      votes: {
        dates:votes_array.collect{|x|x[:date]}.flatten,
        votes:votes_array.collect{|x|x[:votes]}.flatten,
        payouts:votes_array.collect{|x|x[:payout]}.flatten.map{|x|x.round(2)}
      }
    }
  end

end