;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0]{1}[6]{1}[-\s]*([1-9]{1}[\s]*){8})|([0]{1}[1-9]{1}[0-9]{1}[0-9]{1}[-\s]*([1-9]{1}[\s]*){6})|([0]{1}[1-9]{1}[0-9]{1}[-\s]*([1-9]{1}[\s]*){7})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0696  3\xA \x9\u00858 \x9\u00A0\u00A0 \x9 \xD\u00856413"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "6" (seq.++ "9" (seq.++ "6" (seq.++ " " (seq.++ " " (seq.++ "3" (seq.++ "\x0a" (seq.++ " " (seq.++ "\x09" (seq.++ "\x85" (seq.++ "8" (seq.++ " " (seq.++ "\x09" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ " " (seq.++ "\x09" (seq.++ " " (seq.++ "\x0d" (seq.++ "\x85" (seq.++ "6" (seq.++ "4" (seq.++ "1" (seq.++ "3" ""))))))))))))))))))))))))))
;witness2: "\u00C1018\xC 8\u00A09\u00A0\u00A0\x949881\u0082\u00C9n"
(define-fun Witness2 () String (seq.++ "\xc1" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "\x0c" (seq.++ " " (seq.++ "8" (seq.++ "\xa0" (seq.++ "9" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x09" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "\x82" (seq.++ "\xc9" (seq.++ "n" "")))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "6" "")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 8 8) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 6 6) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))) (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 7 7) (re.++ (re.range "1" "9") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
