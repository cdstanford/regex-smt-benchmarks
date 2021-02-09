;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \+44\s\(0\)\s\d{2}\s\d{4}\s\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+44\xD(0)\u00A086 9648\u00859632\u00E4"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "\x0d" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "\xa0" (seq.++ "8" (seq.++ "6" (seq.++ " " (seq.++ "9" (seq.++ "6" (seq.++ "4" (seq.++ "8" (seq.++ "\x85" (seq.++ "9" (seq.++ "6" (seq.++ "3" (seq.++ "2" (seq.++ "\xe4" ""))))))))))))))))))))))
;witness2: "+44 (0)\u008529 9519\u00858899\u0098"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ " " (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "\x85" (seq.++ "2" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "5" (seq.++ "1" (seq.++ "9" (seq.++ "\x85" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "\x98" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" ""))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
