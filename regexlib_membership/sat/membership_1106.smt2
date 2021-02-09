;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}[\s]|[A-Z]{2})[\w]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ZQ9\u00BA"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "Q" (seq.++ "9" (seq.++ "\xba" "")))))
;witness2: "PG 3H"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "G" (seq.++ " " (seq.++ "3" (seq.++ "H" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "A" "Z")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 2 2) (re.range "A" "Z")))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
