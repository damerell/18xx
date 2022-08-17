# frozen_string_literal: true

require_relative '../../../step/token'

module Engine
  module Game
    module G18NY
      module Step
        class Token < Engine::Step::Token
          FREE_HEXES = %w[E1 E25].freeze

          def actions(entity)
            return [] if entity.corporation? && entity.type == :minor

            super
          end

          def process_place_token(action)
            entity = action.entity
            token = action.token
            city = action.city
            hex = city.hex

            if @game.loading
              token.price = action.cost
            else
              # Verify there is a route before spending the time to find the shortest path
              check_connected(entity, city, hex)
              token.price = token_cost(entity, token, hex)
              action.cost = token.price
            end

            if token.price > entity.cash
              raise GameError, "#{entity.name} has #{@game.format_currency(entity.cash)} and cannot spend " \
                               "#{@game.format_currency(token.price)} to lay token"
            end

            super(action)
          end

          def token_cost(entity, token, hex)
            min_distance = 999

            tokened_hexes = entity.tokens.select(&:used).map(&:hex)
            hex.tile.nodes.first&.walk(corporation: entity) do |path, visited_paths, _visited|
              min_distance = [min_distance, distance(visited_paths) - 1].min if tokened_hexes.include?(path.nodes&.first&.hex)
            end

            cost = token.price * min_distance
            cost += @game.class::NYC_TOKEN_COST if @game.second_edition? && hex == @game.nyc_hex
            cost
          end

          def distance(path)
            path.keys.map(&:hex).chunk(&:itself).count { |hex| !FREE_HEXES.include?(hex.id) }
          end
        end
      end
    end
  end
end
