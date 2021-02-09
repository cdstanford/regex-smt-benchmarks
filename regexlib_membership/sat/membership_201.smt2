;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{([1-9]{1}|[1-9]{1}[0-9]{1,}){1}\}\{([1-9]{1}|[1-9]{1}[0-9]{1,}){1}\}(.*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{299}{9}"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "}" (seq.++ "{" (seq.++ "9" (seq.++ "}" "")))))))))
;witness2: "{18}{2}q\u00A0"
(define-fun Witness2 () String (seq.++ "{" (seq.++ "1" (seq.++ "8" (seq.++ "}" (seq.++ "{" (seq.++ "2" (seq.++ "}" (seq.++ "q" (seq.++ "\xa0" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "{" "{")(re.++ (re.union (re.range "1" "9") (re.++ (re.range "1" "9") (re.+ (re.range "0" "9"))))(re.++ (str.to_re (seq.++ "}" (seq.++ "{" "")))(re.++ (re.union (re.range "1" "9") (re.++ (re.range "1" "9") (re.+ (re.range "0" "9"))))(re.++ (re.range "}" "}")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
