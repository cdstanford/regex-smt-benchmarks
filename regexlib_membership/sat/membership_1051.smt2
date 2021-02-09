;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.*\.jpe?g|.*\.JPE?G)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "w.JPEG\xB"
(define-fun Witness1 () String (seq.++ "w" (seq.++ "." (seq.++ "J" (seq.++ "P" (seq.++ "E" (seq.++ "G" (seq.++ "\x0b" ""))))))))
;witness2: "\u00AA.JPEG\u00B2\u00F2"
(define-fun Witness2 () String (seq.++ "\xaa" (seq.++ "." (seq.++ "J" (seq.++ "P" (seq.++ "E" (seq.++ "G" (seq.++ "\xb2" (seq.++ "\xf2" "")))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "." (seq.++ "j" (seq.++ "p" ""))))(re.++ (re.opt (re.range "e" "e")) (re.range "g" "g")))) (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "." (seq.++ "J" (seq.++ "P" ""))))(re.++ (re.opt (re.range "E" "E")) (re.range "G" "G")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
