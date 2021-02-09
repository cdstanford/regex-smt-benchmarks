;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /rapidshare\.com\/files\/(\d+)\/([^\'^\"^\s^>^<^\\^\/]+)/
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "/rapidshare.com/files/9/\u0080/\x4)\u00EE"
(define-fun Witness1 () String (seq.++ "/" (seq.++ "r" (seq.++ "a" (seq.++ "p" (seq.++ "i" (seq.++ "d" (seq.++ "s" (seq.++ "h" (seq.++ "a" (seq.++ "r" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "9" (seq.++ "/" (seq.++ "\x80" (seq.++ "/" (seq.++ "\x04" (seq.++ ")" (seq.++ "\xee" ""))))))))))))))))))))))))))))))
;witness2: "/rapidshare.com/files/9/d}/\x15"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "r" (seq.++ "a" (seq.++ "p" (seq.++ "i" (seq.++ "d" (seq.++ "s" (seq.++ "h" (seq.++ "a" (seq.++ "r" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "9" (seq.++ "/" (seq.++ "d" (seq.++ "}" (seq.++ "/" (seq.++ "\x15" "")))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "/" (seq.++ "r" (seq.++ "a" (seq.++ "p" (seq.++ "i" (seq.++ "d" (seq.++ "s" (seq.++ "h" (seq.++ "a" (seq.++ "r" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "/" "")))))))))))))))))))))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "(" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))))))) (re.range "/" "/")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
