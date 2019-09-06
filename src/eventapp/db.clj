(ns eventapp.db
  (:require [clojure.java.jdbc :as sql]
            [eventapp.util :as util]
            [clojure.string :as str])
  )

(def connection 
  {:classname "org.postgresql.Driver"
   :subprotocol "postgresql"
   :subname "//localhost:5432/eventify"
   :user "postgres"
   :password "changeme"})

(declare get-place-id-by-name)
(declare get-host-ids-by-names)
(defn create-event [name description source eventType hosts place picture prices]
  (def id (java.util.UUID/randomUUID))
  (sql/insert! connection :event [:event_id :event_name :description :source :event_type :place_id :profile_picture] [id name description source eventType (get-place-id-by-name place) picture])
  (doseq [price prices]
    (sql/insert! connection :event_prices [:event_event_id :prices] [id price]))
  (doseq [host (get-host-ids-by-names hosts) ]
    (sql/insert! connection :event_hosts [:event_event_id :hosts_id] [id host])
    )
  )


(defn delete-event [id]
 (sql/delete! connection :event_prices ["event_event_id = ?" id])
 (sql/delete! connection :event_hosts ["event_event_id = ?" id])
 (sql/delete! connection :event
            ["event_id = ?" id]))

(defn get-prices-for-event
  [event-id]
  (into [] (map :prices (sql/query connection ["SELECT prices FROM event_prices where event_event_id = ?" event-id])))
  )

(defn get-place-id-by-name
  [place-name]
  (def uuid (str/join "" (map :place_id (sql/query connection ["SELECT place_id FROM place_names where names = ?" place-name]))))
  (if (= "" uuid) nil (java.util.UUID/fromString uuid))
  )

(defn get-place-name
  [id]
  (reduce str (sql/query connection ["SELECT names FROM event join place_names on (event.place_id = place_names.place_id) where event_id = ?" id]))
  )

(defn get-all-place-names
  []
  (sql/query connection ["select names from place join place_names on (place.id = place_names.place_id)"])
  )

(defn get-host-ids-by-names
  [names]
  (if (= (count names) 0)
    []
    (into [] (map :host_id (sql/query connection [(str "SELECT host_id FROM host_names where names in ('" (str/join "','" names) "')")])))))

(defn get-host-ids-for-event
  [event-id]
  (into [] (map :hosts_id (sql/query connection ["SELECT hosts_id FROM event_hosts where event_event_id = ?" event-id])))
  )

(defn get-host-names-for-event
  [event-id]
  (map :names (sql/query connection ["SELECT names FROM event_hosts join host_names on (event_hosts.hosts_id = host_names.host_id) where event_event_id = ?" event-id]))
  )

(defn get-all-events []
  (def query "SELECT event_id, description, event_date_time, event_name, event_type, profile_picture,string_agg(place_names.names, ', ') as place_names,string_agg(host_names.names, ', ') as host_names, source
    FROM public.event
    left join place on (event.place_id = place.id)
    left join place_names on (place_names.place_id = place.id)
    left join event_hosts on (event.event_id = event_event_id)
    left join host_names on (event_hosts.hosts_id = host_names.host_id)
    group by event_id
    ")

  (into [] (map #(assoc % :place_names (util/convert-place-names (:place_names %))) (sql/query connection [query]))))

(defn get-event-by-id [id]
    (into [] (sql/query connection ["select * from event where event_id = ?" id])))

(defn update-event [id name description source eventType hosts place picture prices]
  (do
      (def place-id (get-place-id-by-name place))
      (sql/update! connection :event (conj {:event_id id :event_name name :description description :source source :event_type eventType  :profile_picture picture } (if (= nil place-id) {} {:place_id place-id}) )  ["event_id = ?" id])
      (doseq [price (util/only-from-first-coll prices (get-prices-for-event id))] (sql/insert! connection :event_prices [:event_event_id :prices] [id price]))
      (doseq [price (util/only-from-first-coll (get-prices-for-event id) prices)]
        (sql/delete! connection :event_prices
                     ["event_event_id = ? and prices = ?" id price])
        )

      (doseq [hostId (util/only-from-first-coll hosts (get-host-ids-for-event id))] (sql/insert! connection :event_hosts [:event_event_id :hosts_id] [id hostId]))
      (doseq [hostId (util/only-from-first-coll (get-host-ids-for-event id) hosts)]
        (sql/delete! connection :event_hosts ["event_event_id = ? and hosts_id = ?" id hostId]))
      )
      )
