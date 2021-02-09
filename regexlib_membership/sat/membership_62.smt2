;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}\s?(\d{2})?(-)?([A-Z]{1}|\d{1})?([A-Z]{1}|\d{1}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "JZ84-I4"
(define-fun Witness1 () String (seq.++ "J" (seq.++ "Z" (seq.++ "8" (seq.++ "4" (seq.++ "-" (seq.++ "I" (seq.++ "4" ""))))))))
;witness2: "CY68-7T"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "Y" (seq.++ "6" (seq.++ "8" (seq.++ "-" (seq.++ "7" (seq.++ "T" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "0" "9") (re.range "A" "Z"))) (re.union (re.range "0" "9") (re.range "A" "Z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
