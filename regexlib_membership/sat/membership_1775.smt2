;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]\:|\\)\\([^\\]+\\)*[^\/:*?"<>|]+\.htm(l)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\\\u00D4\\u00B1\[\x1A\\u0090.htm"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "\u{d4}" (str.++ "\u{5c}" (str.++ "\u{b1}" (str.++ "\u{5c}" (str.++ "[" (str.++ "\u{1a}" (str.++ "\u{5c}" (str.++ "\u{90}" (str.++ "." (str.++ "h" (str.++ "t" (str.++ "m" "")))))))))))))))
;witness2: "\\\u00A4\u00AB\\u00E3P.htm"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "\u{a4}" (str.++ "\u{ab}" (str.++ "\u{5c}" (str.++ "\u{e3}" (str.++ "P" (str.++ "." (str.++ "h" (str.++ "t" (str.++ "m" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.range "\u{5c}" "\u{5c}"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.* (re.++ (re.+ (re.union (re.range "\u{00}" "[") (re.range "]" "\u{ff}"))) (re.range "\u{5c}" "\u{5c}")))(re.++ (re.+ (re.union (re.range "\u{00}" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\u{ff}")))))))))(re.++ (str.to_re (str.++ "." (str.++ "h" (str.++ "t" (str.++ "m" "")))))(re.++ (re.opt (re.range "l" "l")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
