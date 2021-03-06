;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-4][0-9]{2}[\s][B][P][\s][0-9]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "097 BP\u0085859"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "7" (seq.++ " " (seq.++ "B" (seq.++ "P" (seq.++ "\x85" (seq.++ "8" (seq.++ "5" (seq.++ "9" "")))))))))))
;witness2: "018\u00A0BP 899"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "\xa0" (seq.++ "B" (seq.++ "P" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "4")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "B" (seq.++ "P" "")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
