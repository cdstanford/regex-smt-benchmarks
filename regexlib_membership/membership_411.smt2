;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d)+\<\/a\>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "!5</a>\u00D9\x1A\u00EAV\u0083"
(define-fun Witness1 () String (str.++ "!" (str.++ "5" (str.++ "<" (str.++ "/" (str.++ "a" (str.++ ">" (str.++ "\u{d9}" (str.++ "\u{1a}" (str.++ "\u{ea}" (str.++ "V" (str.++ "\u{83}" ""))))))))))))
;witness2: "42</a>"
(define-fun Witness2 () String (str.++ "4" (str.++ "2" (str.++ "<" (str.++ "/" (str.++ "a" (str.++ ">" "")))))))

(assert (= regexA (re.++ (re.+ (re.range "0" "9")) (str.to_re (str.++ "<" (str.++ "/" (str.++ "a" (str.++ ">" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
