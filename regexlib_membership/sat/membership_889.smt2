;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:(?:\+)?1[\-\s\.])?(?:\s?\()?(?:[2-9][0-8][0-9])(?:\))?(?:[\s|\-|\.])?)(?:(?:(?:[2-9][0-9|A-Z][0-9|A-Z])(?:[\s|\-|\.])?)(?:[0-9|A-Z][0-9|A-Z][0-9|A-Z][0-9|A-Z]))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A0\u00AE\u00E0\x21.569)8|||4|6\u0094"
(define-fun Witness1 () String (seq.++ "\xa0" (seq.++ "\xae" (seq.++ "\xe0" (seq.++ "\x02" (seq.++ "1" (seq.++ "." (seq.++ "5" (seq.++ "6" (seq.++ "9" (seq.++ ")" (seq.++ "8" (seq.++ "|" (seq.++ "|" (seq.++ "|" (seq.++ "4" (seq.++ "|" (seq.++ "6" (seq.++ "\x94" "")))))))))))))))))))
;witness2: "\u0090\x19\u00A6887\xC6|DN|8Q"
(define-fun Witness2 () String (seq.++ "\x90" (seq.++ "\x19" (seq.++ "\xa6" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "\x0c" (seq.++ "6" (seq.++ "|" (seq.++ "D" (seq.++ "N" (seq.++ "|" (seq.++ "8" (seq.++ "Q" "")))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "(" "(")))(re.++ (re.range "2" "9")(re.++ (re.range "0" "8")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "|" "|")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.range "2" "9")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "|" "|")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|"))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
