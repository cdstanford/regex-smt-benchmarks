;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\([2-9]|[2-9])(\d{2}|\d{2}\))(-|.|\s)?\d{3}(-|.|\s)?\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(8300667809"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "8" (seq.++ "3" (seq.++ "0" (seq.++ "0" (seq.++ "6" (seq.++ "6" (seq.++ "7" (seq.++ "8" (seq.++ "0" (seq.++ "9" ""))))))))))))
;witness2: "281999G8599"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "G" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "(" "(") (re.range "2" "9")) (re.range "2" "9"))(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range ")" ")")))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
