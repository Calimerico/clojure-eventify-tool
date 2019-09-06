(ns eventapp.view
  (:use hiccup.page hiccup.element)
  (:require
    [hiccup.core :refer [h]]
    [hiccup.form :as form]
    [eventapp.layout :as layout]
    [ring.util.anti-forgery :as anti-forgery]
    [eventapp.db :as db]
    [clojure.string :as str]))

(defn display-all-events [events]
  [:div {:class "card text-center"}
   [:h1 "Show all events"]
   [:p "Latest events from our store"]
   [:br]
   [:table  {:class "table table-bordered"}
    [:th "id"]
    [:th "name"]
    [:th "description"]
    [:th "source"]
    [:th "event type"]
    [:th "hosts"]
    [:th "place"]
    ;[:th "prices"]
    [:th "delete"]
    [:th "update"]
    (map
      (fn [event]
        [:tr 
         [:td (h (:event_id event))]
         [:td (h (:event_name event))]
         [:td (h (:description event))]
         [:td (h (:source event))]
         [:td (h (:event_type event))]
         [:td (h (:host_names event))]
         ;[:td (h (:event_type event))] prices
         [:td (h (:place_names event))]
         [:td [:a {:href (str "/delete/" (h (:event_id event)))} "delete"]]
         [:td [:a {:href (str "/update/" (h (:event_id event)))} "update"]]
         ]) events)]])

(defn select-place-input
  []
  [:div {:class "form-group"}
   (form/label "place" "Place ")
   (form/drop-down {:class "form-control"} "place" (cons "" (map #(:names %) (db/get-all-place-names))))]
  )
(defn add-event-form []
  [:div {:class "form-group card"}
   [:h1 {:class "text-center"} "Add event"]
   (form/form-to [:post "/"]
                 (anti-forgery/anti-forgery-field)
                 [:div {:class "form-group"}
                  (form/label "name" "Name ")
                  (form/text-field {:class "form-control"} "name")]
                 [:div {:class "form-group"}
                  (form/label "description" "Description ")
                  (form/text-field {:class "form-control"}  "description")]
                 [:div {:class "form-group"}
                  (form/label "source" "Source ")
                  (form/text-field {:class "form-control"}  "source")]
                 [:div {:class "form-group"}
                  (form/label "eventType" "Event type ")
                  (form/text-field {:class "form-control"}  "eventType")]
                 [:div {:class "form-group"}
                  [:div {:class "form-group"}
                   (form/label "picture" "Picture ")
                   (form/text-field {:class "form-control"}  "picture")]
                  (form/label "prices" "Prices ")
                  (form/text-field {:class "form-control" :placeholder "Enter host names with coma delimiter!"}  "prices")]
                 (select-place-input)
                 [:div {:class "form-group"}
                  (form/label "hosts" "Hosts ")
                  (form/text-field {:class "form-control" :placeholder "Enter host names with coma delimiter!"}  "hosts")]
                 (form/submit-button {:class "btn btn-primary btn-lg btn-block"}  "Add event")
                 [:br])])

(defn index-page [events]
  (layout/common-layout ""
                        [:div {:class "col-lg-1"}]
                        [:div {:class "col-lg-10"}
                         (display-all-events events)
                         (add-event-form)]
                        [:div {:class "col-lg-1"}]   
                        ))


(defn update-event-form [event]
   (layout/common-layout "" 
  [:div {:class "form-group card"} 
   [:h1 {:class "text-center"} "Update event"]
    (map 
      (fn [event]
     (form/form-to [:post "/update-event"]
                 (anti-forgery/anti-forgery-field)
                 (form/hidden-field "id" (:event_id event))
                 [:div {:class "form-group"}
                  (form/label "name" "Name ")
                  (form/text-field {:class "form-control"} "name" (:event_name event))]
                 [:div {:class "form-group"}                  
                  (form/label "description" "Description ")                  
                  (form/text-field {:class "form-control"}  "description" (:description event))]
                 [:div {:class "form-group"}
                  (form/label "source" "Source ")
                  (form/text-field {:class "form-control"}  "source" (:source event))]
                 [:div {:class "form-group"}                  
                  (form/label "eventType" "Event type")
                  (form/text-field {:class "form-control"}  "eventType" (:event_type event))]
                 [:div {:class "form-group"}
                  (form/label "picture" "Picture ")
                  (form/text-field {:class "form-control"}  "picture" (:profile_picture event))]
                 [:div {:class "form-group"}
                  (form/label "prices" "Prices ")
                  (form/text-field {:class "form-control" :placeholder "Enter prices with coma delimiter!"} "prices" (str/join "," (db/get-prices-for-event (:event_id event))))]
                 (select-place-input)
                 [:div {:class "form-group"}
                  (form/label "hosts" "Hosts ")
                  (form/text-field {:class "form-control" :placeholder "Enter host names with coma delimiter!"}  "hosts" (str/join "," (db/get-host-names-for-event (:event_id event))))]
                 (form/submit-button {:class "btn btn-primary btn-lg btn-block"}  "Update event")
                 [:br])) event)]
    
))


