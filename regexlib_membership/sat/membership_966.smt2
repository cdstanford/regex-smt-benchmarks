;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(?\s*(?<area>\d{3})\s*[\)\.\-]?\s*(?<first>\d{3})\s*[\-\.]?\s*(?<second>\d{4})\D*(?<ext>\d*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "( 799\u0085)993\x9\u00A0.8919"
(define-fun Witness1 () String (seq.++ "(" (seq.++ " " (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "\x85" (seq.++ ")" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "\x09" (seq.++ "\xa0" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "9" ""))))))))))))))))))
;witness2: "\u009B\\u00A7z362\u00A0.868\u00A0\xC\u00A0 .\xD7682X.99\u00AB"
(define-fun Witness2 () String (seq.++ "\x9b" (seq.++ "\x5c" (seq.++ "\xa7" (seq.++ "z" (seq.++ "3" (seq.++ "6" (seq.++ "2" (seq.++ "\xa0" (seq.++ "." (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "\xa0" (seq.++ "\x0c" (seq.++ "\xa0" (seq.++ " " (seq.++ "." (seq.++ "\x0d" (seq.++ "7" (seq.++ "6" (seq.++ "8" (seq.++ "2" (seq.++ "X" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "\xab" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "(" "("))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "-" ".")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "."))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x00" "/") (re.range ":" "\xff"))) (re.* (re.range "0" "9"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
