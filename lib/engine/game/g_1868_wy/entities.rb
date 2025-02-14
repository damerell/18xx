# frozen_string_literal: true

module Engine
  module Game
    module G1868WY
      module Entities
        CORPORATION_RESERVATION_COLOR = '#c6e9af'

        COMPANY_CHOICES = {
          'P3' => %w[P3a P3b P3c],
          'P4' => %w[P4a P4b P4c],
        }.freeze

        def self.def_corporation(**kwargs)
          {
            float_percent: 20,
            tokens: [0, 40, 60, 80],
            always_market_price: true,
            logo: "1868_wy/#{kwargs[:sym]}",
            simple_logo: "1868_wy/#{kwargs[:sym]}.alt",
            reservation_color: CORPORATION_RESERVATION_COLOR,
          }.merge(kwargs).freeze
        end

        CORPORATIONS = [
          def_corporation(
            sym: 'BH',
            name: 'Bighorn Railroad Company',
            coordinates: 'C9',
            color: '#000000',
          ),
          def_corporation(
            sym: 'C&N',
            name: 'Cheyenne & Northern Railway',
            coordinates: 'B16',
            color: '#c00000',
          ),
          def_corporation(
            sym: 'DPR',
            name: 'Denver Pacific Railway and Telegraph Company',
            coordinates: '',
            color: '#4D2674',
          ),
          # rubocop:disable Layout/LineLength
          def_corporation(
            sym: 'LNP',
            name: 'Laramie, North Park and Pacific Railroad and Telegraph Company',
            coordinates: 'M21',
            color: '#FFC425',
            text_color: 'black',
            abilities: [{
              type: 'base',
              description: 'Free Home Green Tile',
              desc_detail: "If M21 does not have a green tile when LNP starts, the green tile is immediately placed for free (skipping yellow if necessary) and does not count against LNP's track points.",
            }],
          ),
          def_corporation(
            sym: 'OSL',
            name: 'Oregon Short Line Railroad',
            coordinates: 'J6',
            color: '#492F24',
            abilities: [{
              type: 'base',
              description: 'Free Home Green Tile',
              desc_detail: "If J6 does not have a green tile when OSL starts, the green tile is immediately placed for free (skipping yellow if necessary) and does not count against OSL's track points.",
            }],
          ),
          def_corporation(
            sym: 'RCL',
            name: 'Rapid City, Black Hills & Western Railroad Company',
            coordinates: 'D28',
            color: '#FFFFFF',
            text_color: 'black',
          ),
          def_corporation(
            sym: 'UP',
            name: 'Union Pacific Railroad',
            coordinates: 'M25',
            color: '#006D9C',
            shares: [20, 10, 10, 10, 10, 10, 10, 20],
            abilities: [
              {
                type: 'base',
                description: 'Ames Brothers 20% Certificate',
                desc_detail: "Before phase 5, as a Stock Round action, P10 may be exchanged for the 20% certificate (the bank capitalizes UP according to its share value at the time of exchange) and then one or both of the shares may immediately be sold (if one share is sold, the cert is exchanged with a 10% cert from the bank pool). At phase 5, the exchange (and capitalization) happens automatically, but no immediate sale is allowed. If P10 is unsold in the initial auction, UP may issue the 20% cert or players may buy it even if other shares are in UP's treasury. If the 20% cert is in the bank pool, UP may not redeem it, and players may only buy it if it is the last available UP certificate. If the UP presidency is dumped on the holder of the 20% cert holder, they may choose to exchange the 20% cert or two 10% certs for the president's cert. If they don't have two 10% certs, and there are sufficient shares in the bank pool, they may immediately buy shares from the bank pool (at the price UP was when the previous president sold) until they have two 10% certs, and then exchange those for the president's certificate. Shares bought in that way effectively subtract from the number of shares sold by the previous president, which may reduce the number of net rows the UP stock price drops due to the previous president's sale.",
              },
              {
                type: 'base',
                description: 'Credit Mobilier',
                desc_detail: 'After yellow track is laid by any Railroad Company in the Credit Mobilier region (row J and south, column 23 and west, outlined in brown) which either extends track west from Omaha or east from Ogden, UP shareholders are paid the total terrain costs of the hex as dividends, even if the track was laid by the Railroad Company for free via a private company ability. Credit Mobilier closes at phase 5, or when the Golden Spike bonus is collected, whichever comes first.',
                remove: '5',
              },
            ]
          ),
          # rubocop:enable Layout/LineLength
          def_corporation(
            sym: 'WNW',
            name: 'Wyoming & North Western Railway',
            coordinates: 'H10',
            color: '#004D95',
          ),
          def_corporation(
            sym: 'WYC',
            name: 'Wyoming Central Railway',
            coordinates: 'H18',
            color: '#f58121',
          ),
        ].freeze

        COMPANIES = [
          {
            name: 'P1 Hell on Wheels',
            sym: 'P1',
            value: 40,
            revenue: 10,
            abilities: [{ type: 'close', on_phase: '5' }],
            desc: 'Closes at phase 5, or the Golden Spike.',
          },
          {
            name: 'P2 Wylie Permanent Camping Company',
            sym: 'P2',
            value: 45,
            revenue: 10,
            abilities: [{ type: 'close', on_phase: '5' },
                        { type: 'revenue_change', revenue: 0, when: 'sold' }],
            desc: 'Revenue changes to $0 when bought by a Railroad. Provides '\
                  'its owning Railroad Company a +$10 revenue bonus for routes '\
                  'starting or ending at either of the accessible Yellowstone entrances. '\
                  'Closes at phase 5.',
          },
          {
            name: 'P3 Developer',
            sym: 'P3',
            value: 70,
            revenue: 10,
            desc: 'Buyer or auction winner chooses one of Union Pacific Coal Company '\
                  '(extra coal DT in phases 2-4, free to place/move), "Buffalo Bill" '\
                  "Cody's Bonanza Oil District (extra oil DT in phase 5+, free to "\
                  'place/move), or Frémont Expedition ($20 discount for every DT)',
          },
          {
            name: 'P3a Union Pacific Coal Company',
            sym: 'P3a',
            value: 70,
            revenue: 10,
            abilities: [{ type: 'close', on_phase: '5' }, { type: 'no_buy' }],
            desc: 'Comes with black coal DT, usable in phases 2-4. Can be placed '\
                  'or moved for terrain cost. May exceed hex\'s coal DT limit. '\
                  'No RR buy-in. Closes at phase 5, removing DT from the game.',
          },
          {
            name: 'P3b "Buffalo Bill" Cody\'s Bonanza Oil District',
            sym: 'P3b',
            value: 70,
            revenue: 10,
            abilities: [{ type: 'close', on_phase: '8' }, { type: 'no_buy' }],
            desc: 'Comes with Oil DT available in phase 5. May exceed hex\'s oil '\
                  'DT limit. No RR buy-in. Closes at phase 8, removing DT from the game.',
          },
          {
            name: 'P3c Frémont Expedition',
            sym: 'P3c',
            value: 70,
            revenue: 10,
            abilities: [{ type: 'close', on_phase: '6' }, { type: 'no_buy' }],
            desc: 'Gives a $20 discount to terrain costs for each Development Token '\
                  'placement. No RR buy-in. Closes at phase 6.',
          },
          {
            name: 'P4 Surveyor',
            sym: 'P4',
            value: 90,
            revenue: 15,
            desc: 'Buyer or auction winner chooses one of Grenville M. Dodge (one '\
                  'time use, 3 free extra yellow tiles), Edward Gillette ($15 off '\
                  'terrain for each tile lay), or Frederick W. Lander ($60 off terrain '\
                  'once per OR)',
          },
          {
            name: 'P4a Grenville M. Dodge',
            sym: 'P4a',
            value: 90,
            revenue: 15,
            abilities: [{ type: 'close', on_phase: '5' },
                        {
                          type: 'tile_lay',
                          when: 'owning_corp_or_turn',
                          owner_type: 'corporation',
                          count: 3,
                          free: true,
                          must_lay_together: true,
                          hexes: [],
                          tiles: %w[3 4 5 6 7 8 9 57 58 YC YL YG Y5b Y5B Y6b Y6B Y57b Y57B],
                          special: false,
                          closed_when_used_up: true,
                        }],
            desc: 'Allows placement of up to three yellow tiles ignoring terrain costs '\
                  'as a free action during tile laying phase. Closes on tile placement or at phase 5.',
          },
          {
            name: 'P4b Edward Gillette',
            sym: 'P4b',
            value: 90,
            revenue: 15,
            abilities: [{ type: 'close', on_phase: '6' },
                        {
                          type: 'tile_discount',
                          discount: 15,
                        }],
            desc: 'Gives owning Railroad Company a $15 discount to terrain costs for '\
                  'each tile lay. Closes at phase 6.',
          },
          {
            name: 'P4c Frederick W. Lander',
            sym: 'P4c',
            value: 90,
            revenue: 15,
            abilities: [{ type: 'close', on_phase: '6' },
                        {
                          type: 'tile_lay',
                          when: 'track',
                          discount: 60,
                          count_per_or: 1,
                          consume_tile_lay: true,
                          reachable: true,
                          special: false,
                          hexes: [],
                          tiles: [],
                        }],
            desc: 'Gives owning Railroad Company a $60 discount for one tile lay per OR. Closes at phase 6.',
          },

          {
            name: 'P5 John S. "General Jack" Casement',
            sym: 'P5',
            value: 100,
            revenue: 20,
            abilities: [{ type: 'close', on_phase: '6' },
                        {
                          type: 'tile_lay',
                          when: 'track',
                          owner_type: 'corporation',
                          count: 3,
                          free: true,
                          must_lay_together: false,
                          hexes: [],
                          tiles: [],
                          special: false,
                          closed_when_used_up: true,
                        }],
            desc: 'Grants owning Railroad Company one extra tile lay/upgrade. '\
                  'May be used 3 times, then closes. Terrain or upgrade costs '\
                  'for this action are ignored. Closes at phase 6.',
          },
          {
            name: 'P6 American Locomotive Corporation 4-8-8-4 "Big Boy" Wasatch Class Locomotive',
            sym: 'P6',
            value: 100,
            revenue: 20,
            abilities: [{ type: 'close', on_phase: '8' }],
            desc: '[+1+1] token extends a train by 1 city and 1 town. The token '\
                  'is assigned to a train when a Railroad Company buys this '\
                  'private company, and may be moved to another train during the '\
                  'train purchasing phase. Closes at phase 8.',
          },
          {
            name: 'P7 The Pure Oil Camp',
            sym: 'P7',
            value: 120,
            revenue: 20,
            abilities: [
              { type: 'close', on_phase: '7' },
              {
                type: 'assign_hexes',
                owner_type: 'corporation',
                when: 'owning_corp_or_turn',
                count: 1,
                hexes: %w[
                  B8 B12 B14 B18 B20 B22 B24 B26
                  C13 C19 C21 C23 C25
                  D10 D14 D18 D22 D26
                  E13 E15 E19 E21 E23 E25
                  F8 F12 F16 F20 F24 F26
                  G5 G13 G15 G17 G19 G21 G23 G25
                  H4 H12 H14 H16 H20 H24 H26
                  I5 I7 I11 I13 I15 I17 I19 I21 I23 I25
                  J4 J8 J10 J14 J16 J18 J22 J24
                  K3 K5 K7 K9 K11 K13 K21 K23 K25
                  L6 L12 L14 L20 L22 L24 L26
                  M3 M5 M7 M9 M11 M13 M17
                ],
              },
            ],
            desc: 'Comes with a Boomtown token that may be placed during any OR '\
                  'anywhere track may be placed. Once it\'s a Boom City, it may '\
                  'only be tokened by the owning Railroad Company. Closes at '\
                  'phase 7, removing Boomtown/City and station token, and tile '\
                  'becomes a Ghost Town.',
          },
          {
            name: "P8 Laramie, Hahn's Peak & Pacific Railway",
            sym: 'P8',
            value: 150,
            revenue: 40,
            abilities: [{ type: 'revenue_change', revenue: 40, on_phase: '3' },
                        { type: 'revenue_change', revenue: 0, on_phase: '5' },
                        { type: 'assign_corporation', owner_type: 'player' }],
            desc: 'Pays $40 revenue ONLY in green phases. Closes, becomes '\
                  'LHP train (permanent 2+1) at phase 5. If owned by a player at '\
                  'the start of phase 5, the LHP train may be immediately assigned '\
                  'to a Railroad Company for no compensation.',
          },
          {
            name: 'P9 Thomas C. Durant',
            sym: 'P9',
            value: 180,
            revenue: 0,
            abilities: [{ type: 'shares', shares: 'UP_0' }],
            desc: "Owner receives the President's certificate of the Union Pacific "\
                  'Railroad, chooses its par value, and it receives 2× that amount. '\
                  'Closes at end of private companies auction.',
          },
          {
            name: 'P10 Oakes and Oliver Ames, Jr.',
            sym: 'P10',
            value: 200,
            revenue: 30,
            abilities: [{ type: 'no_buy' },
                        {
                          type: 'exchange',
                          corporations: ['UP'],
                          owner_type: 'player',
                          when: 'owning_player_sr_turn',
                          from: %i[reserved],
                        }],
            desc: 'May be exchanged for the Ames Brothers double share of the Union '\
                  'Pacific Railroad as an action in a stock round. No RR Buy-in. Closes '\
                  'on share exchange or at phase 5.',
          },
        ].freeze
      end
    end
  end
end
