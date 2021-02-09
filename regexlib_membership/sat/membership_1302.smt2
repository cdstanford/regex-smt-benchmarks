;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]:(\\|(\\[^\\/\s:*"<>|]+)+)>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "J:\>"
(define-fun Witness1 () String (seq.++ "J" (seq.++ ":" (seq.++ "\x5c" (seq.++ ">" "")))))
;witness2: "O:\\u0087>;9\u00D5"
(define-fun Witness2 () String (seq.++ "O" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x87" (seq.++ ">" (seq.++ ";" (seq.++ "9" (seq.++ "\xd5" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range ":" ":")(re.++ (re.union (re.range "\x5c" "\x5c") (re.+ (re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "[")(re.union (re.range "]" "{")(re.union (re.range "}" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))))))))))) (re.range ">" ">")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
