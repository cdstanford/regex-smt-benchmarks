;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{([1-9]{1}|[1-9]{1}[0-9]{1,}){1}\}\{([1-9]{1}|[1-9]{1}[0-9]{1,}){1}\}(.*)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{299}{9}"
(define-fun Witness1 () String (str.++ "{" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "}" (str.++ "{" (str.++ "9" (str.++ "}" "")))))))))
;witness2: "{18}{2}q\u00A0"
(define-fun Witness2 () String (str.++ "{" (str.++ "1" (str.++ "8" (str.++ "}" (str.++ "{" (str.++ "2" (str.++ "}" (str.++ "q" (str.++ "\u{a0}" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "{" "{")(re.++ (re.union (re.range "1" "9") (re.++ (re.range "1" "9") (re.+ (re.range "0" "9"))))(re.++ (str.to_re (str.++ "}" (str.++ "{" "")))(re.++ (re.union (re.range "1" "9") (re.++ (re.range "1" "9") (re.+ (re.range "0" "9"))))(re.++ (re.range "}" "}")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
