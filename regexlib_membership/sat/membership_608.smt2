;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:[a-z]{3},\s+)?(\d{1,2})\s+([a-z]{3})\s+(\d{4})\s+([01][0-9]|2[0-3])\:([0-5][0-9])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "bah,\u00A0 98\u00A0\u0085jze\u00A0\xC\x9 9065\u0085 \u00A023:59"
(define-fun Witness1 () String (seq.++ "b" (seq.++ "a" (seq.++ "h" (seq.++ "," (seq.++ "\xa0" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "j" (seq.++ "z" (seq.++ "e" (seq.++ "\xa0" (seq.++ "\x0c" (seq.++ "\x09" (seq.++ " " (seq.++ "9" (seq.++ "0" (seq.++ "6" (seq.++ "5" (seq.++ "\x85" (seq.++ " " (seq.++ "\xa0" (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "5" (seq.++ "9" ""))))))))))))))))))))))))))))))
;witness2: "vct, \xD 0 \u0085mlm\u00A09282  \u00A0\xD08:50"
(define-fun Witness2 () String (seq.++ "v" (seq.++ "c" (seq.++ "t" (seq.++ "," (seq.++ " " (seq.++ "\x0d" (seq.++ " " (seq.++ "0" (seq.++ " " (seq.++ "\x85" (seq.++ "m" (seq.++ "l" (seq.++ "m" (seq.++ "\xa0" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "2" (seq.++ " " (seq.++ " " (seq.++ "\xa0" (seq.++ "\x0d" (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "5" (seq.++ "0" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ ((_ re.loop 3 3) (re.range "a" "z"))(re.++ (re.range "," ",") (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "a" "z"))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
