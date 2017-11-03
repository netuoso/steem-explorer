module ApplicationHelper
  def gen_operations_html(operations)
    @operations_html = "<table class=\"table table-condensed hash3\">"
    operations.each_with_index do |operation, index|
      @operations_html << "<tr><th class=\"idx\"><samp>#{index}.</samp></th><td><table class=\"table table-condensed hash3\"><tr><th class=\"idx\"><samp>0.</samp></th><td style=\"font-weight: 700\">#{operation[0]}</td></tr><tr><th class=\"idx\"><samp>1.</samp></th><td><table class=\"table table-condensed hash3 ultra-condensed\"><tr><th>"
      case operation[0]
      when 'vote'
        @operations_html << "<samp>voter</samp></th><td>#{operation[1][:voter]}</td></tr><tr><th><samp>author</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:author]}</span></td></tr><tr><th><samp>permlink</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:permlink]}</span></td></tr><tr><th><samp>weight</samp></th><td><i>#{operation[1][:weight]}</i></td></tr></table></table>"
      when 'comment'
        @operations_html << "<samp>parent_author</samp></th><td>#{operation[1][:parent_author]}</td></tr><tr><th><samp>parent_permlink</samp></th><td>#{operation[1][:parent_permlink]}</td></tr><tr><th><samp>author</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:author]}</span></td></tr><tr><th><samp>permlink</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:permlink]}</span></td></tr><tr><th><samp>title</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:title]}</span></td></tr><tr><th><samp>body</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{strip_tags(operation[1][:body])}</span></td></tr><tr><th><samp>json_metadata</samp></th><td>#{operation[1][:json_metadata]}</td></tr></table>"
      when 'comment_options'
        @operations_html << "<samp>author</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:author]}</span></td></tr><tr><th><samp>permlink</samp></th><td><span style=\"font-size: 130%; color: #080;\">#{operation[1][:permlink]}</span></td></tr><tr><th><samp>max_accepted_payout</samp></th><td><i>#{operation[1][:max_accepted_payout]}</i></td></tr><tr><th><samp>percent_steem_dollars</samp></th><td><i>#{operation[1][:percent_steem_dollars]}</i></td></tr><tr><th><samp>allow_votes</samp></th><td><i>#{operation[1][:allow_votes]}</i></td></tr><tr><th><samp>allow_curation_rewards</samp></th><td><i>#{operation[1][:allow_curation_rewards]}</i>"
      when 'custom_json'
        @operations_html << "<samp>required_auths</samp></th><td><samp>#{operation[1][:required_auths]}</samp></td></tr><tr><th><samp>required_posting_auths</samp></th><td><samp>#{operation[1][:required_posting_auths]}</samp></td></tr><tr><th><samp>id</samp></th><td>#{operation[0]}</td></tr><tr><th><samp>json</samp></th><td>#{operation[1][:json]}</td></tr></table></td></tr></table></td></tr></tr>"
      when 'account_witness_vote'
        @operations_html << "<samp>account</samp></th><td>#{operation[1][:account]}</td></tr><tr><th><samp>witness</samp></th><td><samp>#{operation[1][:witness]}</span></td></tr><tr><th><samp>approve</samp></th><td><samp>#{operation[1][:approve]}</samp>"
      when 'claim_reward_balance'
        @operations_html << "<samp>account</samp></th><td>#{operation[1][:account]}</td></tr><tr><th><samp>reward_steem</samp></th><td><samp>#{operation[1][:reward_steem]}</span></td></tr><tr><th><samp>reward_sbd</samp></th><td><samp>#{operation[1][:reward_sbd]}</samp></td></tr><tr><th><samp>reward_vests</samp></th><td><samp>#{operation[1][:reward_vests]}</samp>"
      when 'feed_publish'
        @operations_html << "<samp>publisher</samp></th><td>#{operation[1][:publisher]}</td></tr><tr><th><samp>exchange_rate</samp></th><td><table class=\"table table-condensed hash3 ultra-condensed\"><tr><th><samp>base</samp></th><td><i>#{operation[1][:exchange_rate][:base]}</i></td></tr><tr><th><samp>quote</samp></th><td><i>#{operation[1][:exchange_rate][:quote]}</i></td></tr></table></td></tr></table></td></tr></table></td></tr></table>"
      when 'transfer'
        @operations_html << "<samp>from</samp></th><td>#{operation[1][:from]}</td></tr><tr><th><samp>to</samp></th><td><samp>#{operation[1][:to]}</span></td></tr><tr><th><samp>amount</samp></th><td><samp>#{operation[1][:amount]}</samp></td></tr><tr><th><samp>memo</samp></th><td><samp>#{operation[1][:memo]}</samp>"
      when 'delegate_vesting_shares'
        @operations_html << "<samp>delegator</samp></th><td>#{operation[1][:delegator]}</td></tr><tr><th><samp>delegatee</samp></th><td><samp>#{operation[1][:delegatee]}</span></td></tr><tr><th><samp>vesting_shares</samp></th><td><samp>#{operation[1][:vesting_shares]}</samp>"
      end
    end
    @operations_html << "</td></tr></table></td></tr></table>"
  end

  def gen_signatures_html(signatures)
    @signatures_html = "<table class=\"table table-condensed hash3\" style=\"width: 700px; overflow-x: scroll;\">"
    signatures.each_with_index do |signature, index|
      @signatures_html << "<tr><th class=\"idx\"><samp>#{index}.</samp></th><td style=\"width: 100px\">#{signature}</td></tr>"
    end
    @signatures_html << "</table>"
  end

  def gen_extensions_html(extensions)
    @extensions_html = "[]"
  end

  def gen_transactions_html(transactions)
    @transactions_html = "<table class=\"table table-condensed hash3\">"
    transactions.each_with_index do |transaction, index|
      @transactions_html << "<tr><th class=\"idx\">#{index}.</th><td>#{gen_operations_html(transaction.operations)}</td></tr>"
    end
    @transactions_html << "</table>"
  end

  def gen_discussions_html(discussions, author)
    @discussions_html = "<table id=\"generatedTable\" class=\"table table-condensed\"><thead><tr class=\"text-center\"><th>num</th><th>permlink</th><th>created</th><th>vote count</th><th>payout value</th><th>payout date</th></tr></thead><tbody>"
    @total_votes, @total_replies, @total_payout = 0, 0, 0
    discussions.select{|x|x.depth == 0 && x.author == author}.each_with_index do |discussion, index|
      votes = discussion[:net_votes]
      payout = discussion[:author_rewards].to_f/1000 + discussion[:pending_payout_value].to_f
      @total_votes += votes
      @total_payout += payout
      @discussions_html << "<tr class=#{discussion[:last_payout] == '1970-01-01T00:00:00' ? 'unpaid' : 'paid'}><td>#{index+1}</td><td>#{discussion[:permlink]}</td><td>#{discussion[:created]}</td><td>#{votes}</td><td>#{payout.round(2)} SBD</td><td>#{discussion[:last_payout] == '1970-01-01T00:00:00' ? 'pending' : discussion[:last_payout]}</td></tr>"
    end
    @discussions_html << "<tr class=\"paid\" style=\"font-weight: 700\"><td></td><td>Totals</td><td></td><td>#{@total_votes}</td><td>#{@total_payout.round(2)} SBD</td><td></td></tr></tbody></table>"
  end

  def gen_votes_array(discussions, author)
    @unsorted_votes = []
    discussions.each_with_index do |discussion, index|
      date = discussion[:created]
      votes = discussion[:net_votes]
      payout = discussion[:pending_payout_value].to_f + discussion[:total_payout_value].to_f + discussion[:total_pending_payout_value].to_f
      @unsorted_votes << {date: date.strftime('%Y-%m-%d'), votes: votes.to_i, payout: payout.round(3)}
    end
    @votes = @unsorted_votes.group_by{|x|x[:date]}.collect {|k|{date:k[1][0][:date],votes:k[1].collect{|h|h[:votes]}.sum,payout:k[1].collect{|j| j[:payout]}.sum}}.first(30)
  end

end
