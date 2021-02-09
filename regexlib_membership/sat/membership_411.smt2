;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d)+\<\/a\>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "!5</a>\u00D9\x1A\u00EAV\u0083"
(define-fun Witness1 () String (seq.++ "!" (seq.++ "5" (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ ">" (seq.++ "\xd9" (seq.++ "\x1a" (seq.++ "\xea" (seq.++ "V" (seq.++ "\x83" ""))))))))))))
;witness2: "42</a>"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "2" (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ ">" "")))))))

(assert (= regexA (re.++ (re.+ (re.range "0" "9")) (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "a" (seq.++ ">" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
