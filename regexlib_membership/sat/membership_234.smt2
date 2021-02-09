;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(FR)?\s?[A-Z0-9-[IO]]{2}[0-9]{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "FR\u008590514378578"
(define-fun Witness1 () String (seq.++ "F" (seq.++ "R" (seq.++ "\x85" (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "1" (seq.++ "4" (seq.++ "3" (seq.++ "7" (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "8" "")))))))))))))))
;witness2: "TF192380799"
(define-fun Witness2 () String (seq.++ "T" (seq.++ "F" (seq.++ "1" (seq.++ "9" (seq.++ "2" (seq.++ "3" (seq.++ "8" (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "F" (seq.++ "R" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N") (re.range "P" "Z")))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
