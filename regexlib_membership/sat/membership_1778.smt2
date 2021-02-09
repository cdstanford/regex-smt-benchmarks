;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-zA-Z0-1@.\s]{1,255})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A0"
(define-fun Witness1 () String (seq.++ "\xa0" ""))
;witness2: "\u00A0Q\u00854\u00A0"
(define-fun Witness2 () String (seq.++ "\xa0" (seq.++ "Q" (seq.++ "\x85" (seq.++ "4" (seq.++ "\xa0" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 255) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "." ".")(re.union (re.range "0" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
