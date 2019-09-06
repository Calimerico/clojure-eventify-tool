(ns eventapp.core
  (:use compojure.core
        ring.util.json-response 
        ring.adapter.jetty)
  (:require [compojure.core :refer [defroutes GET POST]]
            [clojure.string :as str]     
            [ring.util.response :as ring]   
            [eventapp.view :as view]
            [eventapp.db :as db]
            [eventapp.util :as util]
            [ring.middleware.resource :refer [wrap-resource]]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            ))


(defn display-all-events []
  (view/index-page (db/get-all-events)))

(defn create-event [name description source eventType hosts place picture prices]
  (when-not (str/blank? name)
    (db/create-event name description source eventType hosts place picture prices))
  (ring/redirect "/"))

(defn delete-event [id]
  (when-not (= nil id)
    (db/delete-event id))
  (ring/redirect "/"))

(defn show-update-view [id]
 (view/update-event-form (db/get-event-by-id id)))

(defn update-event [id name description source eventType hosts place picture prices]
    (when-not (= nil id)
    (db/update-event id name description source eventType hosts place picture prices))
   (view/index-page (db/get-all-events)))

(defroutes my_routes
  (GET "/places" [] (str/join "," (db/get-all-place-names)))
  (GET "/" [] (display-all-events))
  (POST "/" [name description source eventType hosts place picture prices] (create-event name description source eventType (util/split-coma-separated-string hosts) place picture (map #(java.lang.Integer/parseInt %) (util/split-coma-separated-string prices))))
  (POST "/update-event"  [id name description source eventType hosts place picture prices]
    (update-event (java.util.UUID/fromString id) name description source eventType (db/get-host-ids-by-names (util/split-coma-separated-string hosts)) place picture (map #(java.lang.Integer/parseInt %) (util/split-coma-separated-string prices))))
  (GET "/update/:id" [id] (show-update-view (java.util.UUID/fromString id)))
  (GET "/delete/:id" [id]  (delete-event (java.util.UUID/fromString id)))
  (GET "/api/all" [] (json-response (db/get-all-events))))
 

(def app
  (wrap-defaults my_routes site-defaults))
