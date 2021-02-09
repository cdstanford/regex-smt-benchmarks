;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (1)?-?\(?\s*([0-9]{3})\s*\)?\s*-?([0-9]{3})\s*-?\s*([0-9]{4})\s*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1-\x9\u00A0 \u00A0\u0085992 )\u00A0982-7983)J"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "-" (seq.++ "\x09" (seq.++ "\xa0" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ " " (seq.++ ")" (seq.++ "\xa0" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "-" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ ")" (seq.++ "J" ""))))))))))))))))))))))))
;witness2: "1-991\u0085)\u00A0-427\xA\xC2897"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "\x85" (seq.++ ")" (seq.++ "\xa0" (seq.++ "-" (seq.++ "4" (seq.++ "2" (seq.++ "7" (seq.++ "\x0a" (seq.++ "\x0c" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "7" "")))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "(" "("))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
