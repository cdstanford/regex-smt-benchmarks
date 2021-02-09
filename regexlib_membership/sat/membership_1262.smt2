;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0]{1}[6]{1}[-\s]*[1-9]{1}[\s]*([0-9]{1}[\s]*){7})|([0]{1}[1-9]{1}[0-9]{1}[0-9]{1}[-\s]*[1-9]{1}[\s]*([0-9]{1}[\s]*){5})|([0]{1}[1-9]{1}[0-9]{1}[-\s]*[1-9]{1}[\s]*([0-9]{1}[\s]*){6})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "f089\u00A07\xA   0\u00A0588\xD9\u00A05"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "\xa0" (seq.++ "7" (seq.++ "\x0a" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "0" (seq.++ "\xa0" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "\xa0" (seq.++ "5" ""))))))))))))))))))))
;witness2: "0996\xD746\u00A078\u00859 \u00A0\xD"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "\x0d" (seq.++ "7" (seq.++ "4" (seq.++ "6" (seq.++ "\xa0" (seq.++ "7" (seq.++ "8" (seq.++ "\x85" (seq.++ "9" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x0d" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "6" "")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.range "1" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 7 7) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.range "1" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 5 5) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))) (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.range "1" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 6 6) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
