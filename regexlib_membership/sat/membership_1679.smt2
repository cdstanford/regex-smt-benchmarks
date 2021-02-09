;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\(?082|083|084|072\)?[\s-]?[\d]{3}[\s-]?[\d]{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "083"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "8" (seq.++ "3" ""))))
;witness2: "084"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ "4" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "(")) (str.to_re (seq.++ "0" (seq.++ "8" (seq.++ "2" ""))))))(re.union (str.to_re (seq.++ "0" (seq.++ "8" (seq.++ "3" ""))))(re.union (str.to_re (seq.++ "0" (seq.++ "8" (seq.++ "4" "")))) (re.++ (str.to_re (seq.++ "0" (seq.++ "7" (seq.++ "2" ""))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
