;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<1>.*[\\/])(?<2>.+)\.(?<3>.+)?$|^(?<1>.*[\\/])(?<2>.+)$|^(?<2>.+)\.(?<3>.+)?$|^(?<2>.+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00D4.\u00CD"
(define-fun Witness1 () String (seq.++ "\xd4" (seq.++ "." (seq.++ "\xcd" ""))))
;witness2: "\H\x2\u00DC.\u007F"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "H" (seq.++ "\x02" (seq.++ "\xdc" (seq.++ "." (seq.++ "\x7f" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "/" "/") (re.range "\x5c" "\x5c")))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".")(re.++ (re.opt (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "/" "/") (re.range "\x5c" "\x5c")))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".")(re.++ (re.opt (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
