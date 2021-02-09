;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i)(pharmacy)|((p(.{1,3})?h(.{1,3})?a(.{1,3})?r(.{1,3)?m(.{1,3})?a(.{1,3})?c(.{1,3})?y))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3PH\x14A\u00DC\u0090\u00D7rMACyy\x1F"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "P" (seq.++ "H" (seq.++ "\x14" (seq.++ "A" (seq.++ "\xdc" (seq.++ "\x90" (seq.++ "\xd7" (seq.++ "r" (seq.++ "M" (seq.++ "A" (seq.++ "C" (seq.++ "y" (seq.++ "y" (seq.++ "\x1f" ""))))))))))))))))
;witness2: "PhARmaCy"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "h" (seq.++ "A" (seq.++ "R" (seq.++ "m" (seq.++ "a" (seq.++ "C" (seq.++ "y" "")))))))))

(assert (= regexA (re.union (str.to_re (seq.++ "p" (seq.++ "h" (seq.++ "a" (seq.++ "r" (seq.++ "m" (seq.++ "a" (seq.++ "c" (seq.++ "y" ""))))))))) (re.++ (re.range "p" "p")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.range "h" "h")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.range "a" "a")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.range "r" "r")(re.++ (re.opt (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "{" (seq.++ "1" (seq.++ "," (seq.++ "3" "")))))))(re.++ (re.range "m" "m")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.range "a" "a")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.range "c" "c")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))) (re.range "y" "y"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
