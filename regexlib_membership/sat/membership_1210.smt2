;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z|a-z]{2}\s{1}\d{2}\s{1}[A-Z|a-z]{1,2}\s{1}\d{1,4})?([A-Z|a-z]{3}\s{1}\d{1,4})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: "Zz\u00A085\x9OO\x98huz\x93882"
(define-fun Witness2 () String (seq.++ "Z" (seq.++ "z" (seq.++ "\xa0" (seq.++ "8" (seq.++ "5" (seq.++ "\x09" (seq.++ "O" (seq.++ "O" (seq.++ "\x09" (seq.++ "8" (seq.++ "h" (seq.++ "u" (seq.++ "z" (seq.++ "\x09" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "2" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 4) (re.range "0" "9")))))))))(re.++ (re.opt (re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 4) (re.range "0" "9"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
