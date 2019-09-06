(ns eventapp.util
  (:require [clojure.string :as str]
            [clojure.core :as core]
            [clojure.string :as string]
            ))

(defn split-coma-separated-string
  [string]
  (into [] (if (= string "") [] (map #(str/trim %) (str/split string #","))))
  )

(defn only-from-first-coll
  [first-coll second-coll]
  (loop [first first-coll filtered []]
    (if (empty? first)
      filtered
      (let [[element & remaining] first]
        (recur remaining (into filtered (if (nil? (some #{element} second-coll)) [element] [])))
        )
      )
    )
  )

(defn convert-place-names
  [place-names]
  (if (= place-names nil)
    nil
    (do
      (def last-coma-position (string/index-of place-names ","))
      (if (= last-coma-position nil)
        place-names
        (core/subs place-names 0 last-coma-position)
        ))))