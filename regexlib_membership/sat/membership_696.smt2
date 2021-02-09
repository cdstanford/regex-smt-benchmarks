;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &#\d{2,5};
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B8*&#894;\u00F6"
(define-fun Witness1 () String (seq.++ "\xb8" (seq.++ "*" (seq.++ "&" (seq.++ "#" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ ";" (seq.++ "\xf6" ""))))))))))
;witness2: "&#9322;B"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "#" (seq.++ "9" (seq.++ "3" (seq.++ "2" (seq.++ "2" (seq.++ ";" (seq.++ "B" "")))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "#" "")))(re.++ ((_ re.loop 2 5) (re.range "0" "9")) (re.range ";" ";")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
